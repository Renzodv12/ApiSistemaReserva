using Core.Entities;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infraestructura.DBContext.Configurations
{ public class ReservaConfiguration : IEntityTypeConfiguration<Reserva>
    {
        public void Configure(EntityTypeBuilder<Reserva> builder)
        {
            builder.ToTable("reservas");

            builder.HasKey(r => r.Id);

            builder.Property(r => r.Id)
             .HasColumnName("id");

            builder.Property(r => r.FechaHoraInicio)
                .HasColumnName("fecha_hora_inicio")
                .IsRequired();

            builder.Property(r => r.FechaHoraFin)
                .HasColumnName("fecha_hora_fin")
                .IsRequired();

            builder.Property(r => r.PrecioTotal)
                .HasColumnName("precio_total")
                .HasColumnType("DECIMAL(10,2)")
                .IsRequired();

            builder.Property(r => r.Estado)
                .HasColumnName("estado")
                .IsRequired()
                .HasMaxLength(50);



            builder.HasOne(r => r.Usuario)
                .WithMany()
                .HasForeignKey(r => r.IdUsuario)
                .OnDelete(DeleteBehavior.Cascade);

            builder.Property(r => r.IdUsuario)
            .HasColumnName("id_usuario");

            builder.HasOne(r => r.Cancha)
                .WithMany()
                .HasForeignKey(r => r.IdCancha)
                .OnDelete(DeleteBehavior.Cascade);

            builder.Property(r => r.IdCancha)
             .HasColumnName("id_cancha");

        }
    }
}
