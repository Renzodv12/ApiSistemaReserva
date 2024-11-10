using Core.Entities;
using Infraestructura.DBContext.Infraestructura.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]  // Asegura que el usuario esté autenticado
    public class UsuarioController : ControllerBase
    {
        private readonly SistemaReservasContext _context;
        private readonly IConfiguration _configuration;

        public UsuarioController(SistemaReservasContext context, IConfiguration configuration)
        {
            _context = context;
            _configuration = configuration;
        }

        // GET: api/usuario
        [HttpGet]
        public async Task<ActionResult<Usuario>> GetUsuario()
        {
            // Obtener el usuario autenticado desde el JWT
            var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (string.IsNullOrEmpty(userIdClaim))
            {
                return Unauthorized("No se encontró el ID de usuario en los claims.");
            }

            int userId = int.Parse(userIdClaim);

            var usuario = await _context.Usuarios
                .Where(u => u.Id == userId)
                .FirstOrDefaultAsync();

            if (usuario == null)
            {
                return NotFound("Usuario no encontrado.");
            }
            usuario.Contraseña = null;

            return Ok(usuario);
        }

        // GET: api/usuario/profile
        [HttpGet("profile")]
        public async Task<ActionResult<object>> GetProfile()
        {
            // Obtener los claims del JWT
            var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);
            var nameClaim = User.FindFirstValue(ClaimTypes.Name);
            var emailClaim = User.FindFirstValue(ClaimTypes.Email);

            if (string.IsNullOrEmpty(userIdClaim))
            {
                return Unauthorized("No se encontró el ID de usuario en los claims.");
            }

            int userId = int.Parse(userIdClaim);

            var usuario = await _context.Usuarios
                .Where(u => u.Id == userId)
                .Select(u => new
                {
                    u.Nombre,
                    u.Apellido,
                    u.Email,
                    u.FechaRegistro
                })
                .FirstOrDefaultAsync();

            if (usuario == null)
            {
                return NotFound("Usuario no encontrado.");
            }

            return Ok(new
            {
                Id = userId,
                Nombre = usuario.Nombre,
                Apellido = usuario.Apellido,
                Email = usuario.Email,
                FechaRegistro = usuario.FechaRegistro,
                Claims = new
                {
                    UserId = userIdClaim,
                    Name = nameClaim,
                    Email = emailClaim
                }
            });
        }

        // PUT: api/usuario
        [HttpPut]
        public async Task<IActionResult> UpdateUsuario([FromBody] Usuario usuario)
        {
            var userIdClaim = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (string.IsNullOrEmpty(userIdClaim))
            {
                return Unauthorized("No se encontró el ID de usuario en los claims.");
            }

            int userId = int.Parse(userIdClaim);
            var existingUser = await _context.Usuarios.FindAsync(userId);

            if (existingUser == null)
            {
                return NotFound("Usuario no encontrado.");
            }

            // Actualizar los detalles del usuario
            existingUser.Nombre = usuario.Nombre;
            existingUser.Apellido = usuario.Apellido;
            existingUser.Email = usuario.Email;

            _context.Usuarios.Update(existingUser);
            await _context.SaveChangesAsync();

            return NoContent(); // Indica que la actualización fue exitosa pero no retorna contenido.
        }
    }
}
