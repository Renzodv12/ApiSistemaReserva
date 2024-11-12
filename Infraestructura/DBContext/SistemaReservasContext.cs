using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infraestructura.DBContext
{
    using Core.Entities;
    using global::Infraestructura.DBContext.Configurations;
    using Microsoft.EntityFrameworkCore;
    using System.Reflection.Emit;

    namespace Infraestructura.Data
    {
        public class SistemaReservasContext : DbContext
        {
            public SistemaReservasContext(DbContextOptions<SistemaReservasContext> options) : base(options) { }

            public DbSet<Usuario> Usuarios { get; set; }
            public DbSet<Deporte> Deportes { get; set; }
            public DbSet<Localidad> Localidades { get; set; }
            public DbSet<Cancha> Canchas { get; set; }
            public DbSet<Reserva> Reservas { get; set; }
            public DbSet<Recomendacion> Recomendaciones { get; set; }
            public DbSet<Horario> Horario { get; set; }

            protected override void OnModelCreating(ModelBuilder modelBuilder)
            {   
                  // Aquí se cargan las configuraciones
                modelBuilder.ApplyConfiguration(new UsuarioConfiguration());
                modelBuilder.ApplyConfiguration(new DeporteConfiguration());
                modelBuilder.ApplyConfiguration(new LocalidadConfiguration());
                modelBuilder.ApplyConfiguration(new CanchaConfiguration());
                modelBuilder.ApplyConfiguration(new ReservaConfiguration());
                modelBuilder.ApplyConfiguration(new RecomendacionConfiguration());
                modelBuilder.ApplyConfiguration(new HorarioConfiguration());

                // Configuración adicional de entidades
                base.OnModelCreating(modelBuilder);
            }
        }
    }

}
