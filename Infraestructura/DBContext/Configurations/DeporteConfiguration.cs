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
    public class DeporteConfiguration : IEntityTypeConfiguration<Deporte>
    {
        public void Configure(EntityTypeBuilder<Deporte> builder)
        {
            builder.ToTable("deportes");

            builder.HasKey(d => d.Id);

            builder.Property(r => r.Id)
             .HasColumnName("id");

            builder.Property(d => d.Nombre)
                .HasColumnName("nombre")
                .IsRequired()
                .HasMaxLength(50);

            builder.Property(d => d.Descripcion)
                .HasColumnName("descripcion")
                .HasColumnType("TEXT");
        }
    }
}
