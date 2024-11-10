using Core.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using System;
using Infraestructura.DBContext.Infraestructura.Data;
using Microsoft.EntityFrameworkCore;

namespace Reservas.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ReservaController : ControllerBase
    {
        private readonly SistemaReservasContext _context;

        public ReservaController(SistemaReservasContext context)
        {
            _context = context;
        }

        // Obtener todas las reservas del usuario autenticado
        [Authorize]
        [HttpGet("mis-reservas")]
        public async Task<IActionResult> GetMisReservas()
        {
            var userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;


            var reservas = await _context.Reservas
                .Where(r => r.IdUsuario.ToString() == userId)
                .Include(r => r.Cancha)  // Incluir la cancha asociada
                .Include(r => r.Cancha.Deporte)  // Incluir el deporte de la cancha
                .Include(r => r.Cancha.Localidad)  // Incluir la localidad de la cancha
                .ToListAsync();

            return Ok(reservas);
        }

        // Crear una nueva reserva
        [Authorize]
        [HttpPost("reservar")]
        public async Task<IActionResult> CrearReserva([FromBody] Reserva reservaDto)
        {
            var userId = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;

            // Verificar si la cancha está disponible en el rango de tiempo
            var isDisponible = !await _context.Reservas
                .AnyAsync(r => r.IdCancha == reservaDto.IdCancha &&
                               r.FechaHoraInicio < reservaDto.FechaHoraFin &&
                               r.FechaHoraFin > reservaDto.FechaHoraInicio);

            if (!isDisponible)
            {
                return BadRequest("La cancha no está disponible en el rango de tiempo seleccionado.");
            }

            // Crear una nueva reserva
            var reserva = new Reserva
            {
                IdUsuario = int.Parse(userId),
                IdCancha = reservaDto.IdCancha,
                FechaHoraInicio = reservaDto.FechaHoraInicio,
                FechaHoraFin = reservaDto.FechaHoraFin,
                PrecioTotal = reservaDto.PrecioTotal,
                Estado = "Pendiente"  // Por ejemplo, la reserva está pendiente hasta que se confirme
            };

            // Guardar la reserva en la base de datos
            _context.Reservas.Add(reserva);
            await _context.SaveChangesAsync();

            return Ok(new { mensaje = "Reserva creada con éxito", reservaId = reserva.Id });
        }
    }
}
