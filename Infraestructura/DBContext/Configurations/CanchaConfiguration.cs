using Core.Entities;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infraestructura.DBContext.Configurations
{
    public class CanchaConfiguration : IEntityTypeConfiguration<Cancha>
    {
        public void Configure(EntityTypeBuilder<Cancha> builder)
        {
            builder.ToTable("canchas");

            builder.HasKey(c => c.Id);

            builder.Property(r => r.Id)
             .HasColumnName("id");

            builder.Property(c => c.Nombre)
                .HasColumnName("nombre")
                .IsRequired()
                .HasMaxLength(100);

            builder.Property(c => c.Capacidad)
                .HasColumnName("capacidad");

            builder.Property(c => c.PrecioPorHora)
                .HasColumnName("precio_por_hora")
                .HasColumnType("DECIMAL(10,2)")
                .IsRequired();
            builder.HasOne(c => c.Deporte)
               .WithMany()
               .HasForeignKey(c => c.DeporteId)
               .HasConstraintName("fk_cancha_deporte") // Opcional: nombre para la restricción de la clave foránea
               .OnDelete(DeleteBehavior.Restrict);

            // Especificar el nombre de la columna para la propiedad IdDeporte
            builder.Property(c => c.DeporteId)
                .HasColumnName("id_deporte");




            builder.HasOne(c => c.Localidad)
                .WithMany()
                .HasForeignKey(c => c.IdLocalidad)
                .OnDelete(DeleteBehavior.Restrict);

            builder.Property(c => c.IdLocalidad)
           .HasColumnName("id_localidad");
        }
    }
}
