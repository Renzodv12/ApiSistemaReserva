using Hangfire;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Recomendaciones;
using System.Security.Claims;

namespace Reservas.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class RecomendacionesController : ControllerBase
    {
        private readonly RecommendationEngine _recommendationEngine;
        private readonly IRecurringJobManager _recurringJobManager;

        public RecomendacionesController(
            RecommendationEngine recommendationEngine,
            IRecurringJobManager recurringJobManager)
        {
            _recommendationEngine = recommendationEngine;
            _recurringJobManager = recurringJobManager;
        }
        [Authorize]
        [HttpGet("usuario")]
        public async Task<IActionResult> GetRecomendaciones(
            [FromQuery] decimal? maxPrice = null,
            [FromQuery] int? preferredHour = null,
            [FromQuery] int? preferredLocalidad = null,
            [FromQuery] int? minCapacity = null)
        {
            try
            {
                var userIdLog = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;

                var userId = Convert.ToInt32(userIdLog ?? "0" );  // Obtener el ID del usuario desde el token JWT
                var recomendaciones = await _recommendationEngine.GetRecommendations(
                    userId,
                    maxPrice ?? decimal.MaxValue,
                    preferredHour,
                    preferredLocalidad,
                    minCapacity
                );

                return Ok(recomendaciones);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Error al obtener recomendaciones", error = ex.Message });
            }
        }

        [HttpPost("reentrenar")]
        public IActionResult ConfigurarReentrenamiento([FromBody] int intervaloHoras = 24)
        {
            try
            {
                _recurringJobManager.AddOrUpdate(
                    "reentrenamiento-modelo",
                    () => _recommendationEngine.TrainModelAsync(),
                    $"0 */{intervaloHoras} * * *" // Expresión CRON
                );

                return Ok(new { message = $"Reentrenamiento programado cada {intervaloHoras} horas" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Error al configurar reentrenamiento", error = ex.Message });
            }
        }
    }
}
