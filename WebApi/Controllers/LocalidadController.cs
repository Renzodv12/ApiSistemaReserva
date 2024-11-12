using Core.Entities;
using Infraestructura.DBContext.Infraestructura.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;

namespace Reservas.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LocalidadController : ControllerBase
    {
        private readonly SistemaReservasContext _context;

        public LocalidadController(SistemaReservasContext context)
        {
            _context = context;
        }

        // GET: api/Localidad
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Localidad>>> GetLocalidades()
        {
            var localidades = await _context.Localidades
               // .Include(l => l.Canchas)  // Incluyendo las canchas asociadas a la localidad
                .ToListAsync();

            return Ok(localidades);
        }

        // GET: api/Localidad/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Localidad>> GetLocalidad(int id)
        {
            var localidad = await _context.Localidades
                .FirstOrDefaultAsync(l => l.Id == id);

            if (localidad == null)
            {
                return NotFound();
            }

            return Ok(localidad);
        }

        // POST: api/Localidad
        [HttpPost]
        public async Task<ActionResult<Localidad>> PostLocalidad(Localidad localidad)
        {
            if (localidad == null)
            {
                return BadRequest();
            }

            _context.Localidades.Add(localidad);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetLocalidad), new { id = localidad.Id }, localidad);
        }

        // PUT: api/Localidad/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutLocalidad(int id, Localidad localidad)
        {
            if (id != localidad.Id)
            {
                return BadRequest();
            }

            _context.Entry(localidad).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!LocalidadExists(id))
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

        // DELETE: api/Localidad/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteLocalidad(int id)
        {
            var localidad = await _context.Localidades.FindAsync(id);
            if (localidad == null)
            {
                return NotFound();
            }

            _context.Localidades.Remove(localidad);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool LocalidadExists(int id)
        {
            return _context.Localidades.Any(l => l.Id == id);
        }
    }
}
