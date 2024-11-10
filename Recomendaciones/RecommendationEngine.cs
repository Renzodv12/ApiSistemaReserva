using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;
using System;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using Core.Entities;
using Npgsql;
using Core.Models;

namespace Recomendaciones
{
    public class RecommendationEngine
{
    private readonly MLContext _mlContext;
    private ITransformer _model;
    private readonly string _connectionString;
    private readonly string _modelPath;
    private DataViewSchema _modelSchema;

    public RecommendationEngine(string connectionString)
    {
        _mlContext = new MLContext(seed: 1);
        _connectionString = connectionString;
        _modelPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Models", "recommendation_model.zip");
    }

    public async Task InitializeModel()
    {
        try
        {
            // Asegurarse de que el directorio existe
            var modelDirectory = Path.GetDirectoryName(_modelPath);
            if (!Directory.Exists(modelDirectory))
            {
                Directory.CreateDirectory(modelDirectory);
            }

            // Verificar si el modelo existe
            if (File.Exists(_modelPath))
            {
              //  _logger.LogInformation("Cargando modelo existente...");
                await LoadModelAsync();
            }
            else
            {
                //_logger.LogInformation("Modelo no encontrado. Entrenando nuevo modelo...");
                await TrainModelAsync();
            }
        }
        catch (Exception ex)
        {
           // _logger.LogError(ex, "Error durante la inicialización del modelo");
            throw;
        }
    }

    private async Task LoadModelAsync()
    {
        try
        {
            using (var stream = new FileStream(_modelPath, FileMode.Open, FileAccess.Read, FileShare.Read))
            {
                _model = await Task.Run(() => _mlContext.Model.Load(stream, out _modelSchema));
            }
          //  _logger.LogInformation("Modelo cargado exitosamente");
        }
        catch (Exception ex)
        {
          //  _logger.LogError(ex, "Error al cargar el modelo. Se procederá a entrenar uno nuevo");
            await TrainModelAsync();
        }
    }

    public async Task TrainModelAsync()
    {
        try
        {
           // _logger.LogInformation("Iniciando entrenamiento del modelo...");

            var trainingData = await LoadTrainingDataAsync();

            // Verificar si hay datos de entrenamiento
            var rowCount = trainingData.GetRowCount();
            if (rowCount == 0)
            {
                throw new InvalidOperationException("No hay datos suficientes para entrenar el modelo");
            }

           // _logger.LogInformation($"Entrenando modelo con {rowCount} registros");

            var pipeline = BuildPipeline();
            _model = pipeline.Fit(trainingData);
            _modelSchema = trainingData.Schema;

            // Guardar el modelo
            await SaveModelAsync();

          //  _logger.LogInformation("Modelo entrenado y guardado exitosamente");
        }
        catch (Exception ex)
        {
         //  _logger.LogError(ex, "Error durante el entrenamiento del modelo");
            throw;
        }
    }

    private async Task SaveModelAsync()
    {
        try
        {
            using (var stream = new FileStream(_modelPath, FileMode.Create, FileAccess.Write, FileShare.None))
            {
                await Task.Run(() => _mlContext.Model.Save(_model, _modelSchema, stream));
            }
        }
        catch (Exception ex)
        {
           // _logger.LogError(ex, "Error al guardar el modelo");
            throw;
        }
    }

    private async Task<IDataView> LoadTrainingDataAsync()
    {
        var trainingData = new List<ReservaData>();

        using (var connection = new NpgsqlConnection(_connectionString))
        {
            await connection.OpenAsync();
            using var command = new NpgsqlCommand(@"
                SELECT 
                    r.id_usuario,
                    r.id_cancha,
                    c.precio_por_hora,
                    EXTRACT(HOUR FROM r.fecha_hora_inicio) as hora,
                    c.id_localidad,
                    c.capacidad,
                    CASE 
                        WHEN r.estado = 'Confirmada' THEN 5
                        WHEN r.estado = 'Pendiente' THEN 3
                        WHEN r.estado = 'Cancelada' THEN 1
                    END as rating
                FROM reservas r
                JOIN canchas c ON r.id_cancha = c.id", connection);

            using var reader = await command.ExecuteReaderAsync();
            while (await reader.ReadAsync())
            {
                trainingData.Add(new ReservaData
                {
                    UserId = reader.GetInt32(0),
                    CanchaId = reader.GetInt32(1),
                    Price = (float)reader.GetDecimal(2),
                    Hour = reader.GetInt32(3),
                    LocalidadId = reader.GetInt32(4),
                    Capacity = reader.GetInt32(5),
                    Rating = reader.GetInt32(6)
                });
            }
        }

        return _mlContext.Data.LoadFromEnumerable(trainingData);
    }

    public async Task<List<Cancha>> GetRecommendations(
        int userId,
        decimal maxPrice = decimal.MaxValue,
        int? preferredHour = null,
        int? preferredLocalidad = null,
        int? minCapacity = null)
    {
        try
        {
            if (_model == null)
            {
               await LoadModelAsync();
            }

                var canchas = await GetAllCanchas();
            var predictions = new List<(Cancha cancha, float score)>();

            // Crear predictor
            var predictionEngine = _mlContext.Model.CreatePredictionEngine<ReservaData, ReservaPrediction>(_model);

            foreach (var cancha in canchas)
            {
                var predictionData = new ReservaData
                {
                    UserId = userId,
                    CanchaId = cancha.Id,
                    Price = (float)cancha.PrecioPorHora,
                    Hour = preferredHour ?? 12,
                    LocalidadId = cancha.IdLocalidad,
                    Capacity = cancha.Capacidad
                };

                var prediction = predictionEngine.Predict(predictionData);
                predictions.Add((cancha, prediction.Score));
            }

            return predictions
                .Where(p => p.cancha.PrecioPorHora <= maxPrice &&
                           (!preferredLocalidad.HasValue || p.cancha.IdLocalidad == preferredLocalidad) &&
                           (!minCapacity.HasValue || p.cancha.Capacidad >= minCapacity))
                .OrderByDescending(p => p.score)
                .Select(p => p.cancha)
                .ToList();
        }
        catch (Exception ex)
        {
         //   _logger.LogError(ex, "Error al obtener recomendaciones");
            throw;
        }
    }

    private IEstimator<ITransformer> BuildPipeline()
    {
        return _mlContext.Transforms.Conversion.MapValueToKey(
                outputColumnName: "UserIdEncoded",
                inputColumnName: nameof(ReservaData.UserId))
            .Append(_mlContext.Transforms.Conversion.MapValueToKey(
                outputColumnName: "CanchaIdEncoded",
                inputColumnName: nameof(ReservaData.CanchaId)))
            .Append(_mlContext.Transforms.Concatenate(
                "Features",
                nameof(ReservaData.Price),
                nameof(ReservaData.Hour),
                nameof(ReservaData.LocalidadId),
                nameof(ReservaData.Capacity)))
            .Append(_mlContext.Transforms.NormalizeMinMax("Features"))
            .Append(_mlContext.Recommendation().Trainers.MatrixFactorization(
                labelColumnName: nameof(ReservaData.Rating),
                matrixColumnIndexColumnName: "UserIdEncoded",
                matrixRowIndexColumnName: "CanchaIdEncoded"));
    }

    private async Task<List<Cancha>> GetAllCanchas()
    {
        var canchas = new List<Cancha>();

        using (var connection = new NpgsqlConnection(_connectionString))
        {
            await connection.OpenAsync();
            using var command = new NpgsqlCommand(
                "SELECT id, nombre, capacidad, precio_por_hora, id_deporte, id_localidad FROM canchas",
                connection);

            using var reader = await command.ExecuteReaderAsync();
            while (await reader.ReadAsync())
            {
                canchas.Add(new Cancha
                {
                    Id = reader.GetInt32(0),
                    Nombre = reader.GetString(1),
                    Capacidad = reader.GetInt32(2),
                    PrecioPorHora = reader.GetDecimal(3),
                    DeporteId = reader.GetInt32(4),
                    IdLocalidad = reader.GetInt32(5)
                });
            }
        }

        return canchas;
    }
}
}