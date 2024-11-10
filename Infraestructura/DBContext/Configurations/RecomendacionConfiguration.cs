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
    public class RecomendacionConfiguration : IEntityTypeConfiguration<Recomendacion>
    {
        public void Configure(EntityTypeBuilder<Recomendacion> builder)
        {
            builder.ToTable("recomendaciones");

            builder.HasKey(r => r.Id);

            builder.Property(r => r.Id)
             .HasColumnName("id");

            builder.Property(r => r.TipoRecomendacion)
                .HasColumnName("tipo_recomendacion")
                .IsRequired()
                .HasMaxLength(50);

            builder.Property(r => r.Prioridad)
                .HasColumnName("prioridad")
                .HasDefaultValue(1);

            builder.Property(r => r.FechaCreacion)
                .HasColumnName("fecha_creacion")
                .HasDefaultValueSql("CURRENT_TIMESTAMP");

            builder.Property(r => r.IdUsuario)
                .HasColumnName("id_usuario");

            builder.HasOne(r => r.Usuario)
                .WithMany()
                .HasForeignKey(r => r.IdUsuario)
                .OnDelete(DeleteBehavior.Cascade);

            builder.Property(r => r.IdCancha)
             .HasColumnName("id_cancha");

            builder.HasOne(r => r.Cancha)
                .WithMany()
                .HasForeignKey(r => r.IdCancha)
                .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
