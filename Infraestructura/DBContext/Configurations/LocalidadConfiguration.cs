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
    public class LocalidadConfiguration : IEntityTypeConfiguration<Localidad>
    {
        public void Configure(EntityTypeBuilder<Localidad> builder)
        {
            builder.ToTable("localidades");

            builder.HasKey(l => l.Id);

            builder.Property(r => r.Id)
             .HasColumnName("id");

            builder.Property(l => l.Nombre)
                .HasColumnName("nombre")
                .IsRequired()
                .HasMaxLength(100);

            builder.Property(l => l.Direccion)
                .HasColumnName("direccion")
                .HasMaxLength(200);

            builder.Property(l => l.CodigoPostal)
                .HasColumnName("codigo_postal")
                .HasMaxLength(10);
        }
    }
}
