using Hangfire;
using Hangfire.PostgreSql;
using Infraestructura.DBContext.Infraestructura.Data;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using Recomendaciones;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();

builder.Services.AddSwaggerGen(c =>
{
    // Configuraci�n del esquema de seguridad para JWT
    c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Name = "Authorization",
        Type = SecuritySchemeType.Http,
        Scheme = "Bearer",
        BearerFormat = "JWT",
        In = ParameterLocation.Header,
        Description = "Ingrese 'Bearer' [espacio] y el token JWT en el campo de texto.",
    });

    c.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            new string[] {}
        }
    });
});
// Configura DbContext para PostgreSQL
builder.Services.AddDbContext<SistemaReservasContext>(options =>
    options.UseNpgsql(builder.Configuration.GetConnectionString("DefaultConnection")));
// Configurar Hangfire
builder.Services.AddHangfire(config => config
    .SetDataCompatibilityLevel(CompatibilityLevel.Version_170)
    .UseSimpleAssemblyNameTypeSerializer()
    .UseRecommendedSerializerSettings()
    .UsePostgreSqlStorage(builder.Configuration.GetConnectionString("DefaultConnection")));

builder.Services.AddHangfireServer();
// Configuraci�n de JWT
var key = Encoding.ASCII.GetBytes(builder.Configuration["Jwt:SecretKey"]);

builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
        .AddJwtBearer(options =>
        {
            options.TokenValidationParameters = new TokenValidationParameters
            {
                ValidateIssuer = false,
                ValidateAudience = false,
                ValidateLifetime = true,
                ValidateIssuerSigningKey = true,
                ValidIssuer = builder.Configuration["Jwt:Issuer"],
                ValidAudience = builder.Configuration["Jwt:Audience"],
                IssuerSigningKey = new SymmetricSecurityKey(key)
            };

            options.Events = new JwtBearerEvents
            {
                OnAuthenticationFailed = context =>
                {
                    // Aqu� puedes ver los detalles del error
                    Console.WriteLine("Authentication failed: " + context.Exception.Message);
                    return Task.CompletedTask;
                },
                OnTokenValidated = context =>
                {
                    // Aqu� puedes ver si el token fue validado correctamente
                    Console.WriteLine("Token validated");
                    return Task.CompletedTask;
                }
            };
        });


builder.Services.AddAuthorization();

// Agregar el servicio RecommendationEngine al contenedor DI
builder.Services.AddScoped<RecommendationEngine>(provider =>
    new RecommendationEngine(builder.Configuration.GetConnectionString("DefaultConnection")));

builder.Services.AddLogging(logging =>
{
    logging.AddConsole();
    logging.AddDebug();
});

//CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy("CorsPolicity",
    builder => builder.WithOrigins("http://localhost:5173/")
    .AllowAnyMethod()
    .AllowAnyHeader()
    .AllowCredentials()

    );
});

var app = builder.Build();
app.UseHangfireDashboard("/hangfire", new DashboardOptions
{
    //Authorization = new[] { new HangfireAuthorizationFilter() }
});
// Configurar el pipeline de solicitudes HTTP
var logger = app.Services.GetRequiredService<ILogger<RecommendationEngine>>();
var recommendationEngine = app.Services.CreateScope().ServiceProvider.GetRequiredService<RecommendationEngine>();

// Programar el reentrenamiento
var recurringJobManager = app.Services.GetRequiredService<IRecurringJobManager>();
recurringJobManager.AddOrUpdate(
    "reentrenamiento-modelo",
    () => recommendationEngine.TrainModelAsync(),
    Cron.Daily, // Reentrenamiento diario
    new RecurringJobOptions { TimeZone = TimeZoneInfo.Local }
);

logger.LogInformation("Sistema de recomendaciones inicializado y configurado");
//Procesos 
// Inicializaci�n
//var recommendationEngine = app.Services.GetRequiredService<RecommendationEngine>();
await recommendationEngine.InitializeModel();

// Configure the HTTP request pipeline.
//if (app.Environment.IsDevelopment())
//{
    app.UseSwagger();
    app.UseSwaggerUI();
//}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
