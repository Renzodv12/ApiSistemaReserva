using Core.Entities;
using Infraestructura.DBContext.Infraestructura.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DeporteController : ControllerBase
    {
        private readonly SistemaReservasContext _context;

        public DeporteController(SistemaReservasContext context)
        {
            _context = context;
        }

        // GET: api/deportes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Deporte>>> GetDeportes()
        {
            var deportes = await _context.Deportes.ToListAsync();
            return Ok(deportes);
        }

        // GET: api/deportes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Deporte>> GetDeporte(int id)
        {
            var deporte = await _context.Deportes.FindAsync(id);

            if (deporte == null)
            {
                return NotFound();
            }

            return Ok(deporte);
        }

        // POST: api/deportes
        [HttpPost]
        public async Task<ActionResult<Deporte>> PostDeporte([FromBody] Deporte deporte)
        {
            if (deporte == null)
            {
                return BadRequest("El deporte no puede ser nulo.");
            }

            // Agregar el nuevo deporte
            _context.Deportes.Add(deporte);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetDeporte), new { id = deporte.Id }, deporte);
        }

        // PUT: api/deportes/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutDeporte(int id, [FromBody] Deporte deporte)
        {
            if (id != deporte.Id)
            {
                return BadRequest("El ID del deporte no coincide.");
            }

            _context.Entry(deporte).State = EntityState.Modified;
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!DeporteExists(id))
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

        // DELETE: api/deportes/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteDeporte(int id)
        {
            var deporte = await _context.Deportes.FindAsync(id);
            if (deporte == null)
            {
                return NotFound();
            }

            _context.Deportes.Remove(deporte);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        // Método auxiliar para verificar si el deporte existe
        private bool DeporteExists(int id)
        {
            return _context.Deportes.Any(e => e.Id == id);
        }
    }
}
