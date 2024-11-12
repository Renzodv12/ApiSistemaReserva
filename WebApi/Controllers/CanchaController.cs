using Core.Entities;
using Infraestructura.DBContext.Infraestructura.Data;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;

namespace Reservas.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CanchaController : ControllerBase
    {
        private readonly SistemaReservasContext _context;

        public CanchaController(SistemaReservasContext context)
        {
            _context = context;
        }

        // GET: api/Cancha
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Cancha>>> GetCanchas()
        {
            var canchas = await _context.Canchas
                .Include(c => c.Deporte)
                .Include(c => c.Localidad)
                .ToListAsync();

            return Ok(canchas);
        }

        // GET: api/Cancha/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Cancha>> GetCancha(int id)
        {
            var cancha = await _context.Canchas
                .Include(c => c.Deporte )
                .Include(c => c.Localidad)
                .FirstOrDefaultAsync(c => c.Id == id);

            if (cancha == null)
            {
                return NotFound();
            }

            return Ok(cancha);
        }

        // GET: api/Cancha/filter
        [HttpGet("filter")]
        public async Task<ActionResult<IEnumerable<Cancha>>> GetCanchasByFilter(
            [FromQuery] int? localidadId,
            [FromQuery] DateTime? fechaInicio,
            [FromQuery] DateTime? fechaFin,
            [FromQuery] int? deporteId)
        {
            var query = _context.Canchas
                .Include(c => c.Deporte)
                .Include(c => c.Localidad)
                .AsQueryable();

            // Filtrar por localidad
            if (localidadId.HasValue)
            {
                query = query.Where(c => c.IdLocalidad == localidadId.Value);
            }

            // Filtrar por deporte
            if (deporteId.HasValue)
            {
                query = query.Where(c => c.DeporteId == deporteId.Value);
            }

            // Filtrar por fecha (verificar si la cancha está reservada en ese rango de tiempo)
            if (fechaInicio.HasValue && fechaFin.HasValue)
            {
                query = query.Where(c => !_context.Reservas
                    .Any(r => r.IdCancha == c.Id && (
                        (r.FechaHoraInicio >= fechaInicio.Value && r.FechaHoraInicio <= fechaFin.Value) ||
                        (r.FechaHoraFin >= fechaInicio.Value && r.FechaHoraFin <= fechaFin.Value) ||
                        (r.FechaHoraInicio <= fechaInicio.Value && r.FechaHoraFin >= fechaFin.Value)
                    )));
            }

            var canchas = await query.ToListAsync();

            return Ok(canchas);
        }
        // POST: api/Cancha
        [HttpPost]
        public async Task<ActionResult<Cancha>> PostCancha(Cancha cancha)
        {
            if (cancha == null)
            {
                return BadRequest();
            }

            _context.Canchas.Add(cancha);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetCancha), new { id = cancha.Id }, cancha);
        }

        // PUT: api/Cancha/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCancha(int id, Cancha cancha)
        {
            if (id != cancha.Id)
            {
                return BadRequest();
            }

            _context.Entry(cancha).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CanchaExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // DELETE: api/Cancha/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCancha(int id)
        {
            var cancha = await _context.Canchas.FindAsync(id);
            if (cancha == null)
            {
                return NotFound();
            }

            _context.Canchas.Remove(cancha);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool CanchaExists(int id)
        {
            return _context.Canchas.Any(c => c.Id == id);
        }
    }
}
