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
    public class UsuarioConfiguration : IEntityTypeConfiguration<Usuario>
    {
        public void Configure(EntityTypeBuilder<Usuario> builder)
        {
            builder.ToTable("usuarios");

            builder.HasKey(u => u.Id);

            builder.Property(r => r.Id)
             .HasColumnName("id");

            builder.Property(u => u.Nombre)
                .HasColumnName("nombre")
                .IsRequired()
                .HasMaxLength(50);

            builder.Property(u => u.Apellido)
                .HasColumnName("apellido")
                .IsRequired()
                .HasMaxLength(50);

            builder.Property(u => u.Email)
                .HasColumnName("email")
                .IsRequired()
                .HasMaxLength(100);

            builder.Property(u => u.Contraseña)
                .HasColumnName("contraseña")
                .IsRequired()
                .HasMaxLength(100);

            builder.Property(u => u.FechaRegistro)
                .HasColumnName("fecha_registro")
                .HasDefaultValueSql("CURRENT_DATE");

            builder.Property(u => u.Activo)
                .HasColumnName("activo")
                .HasDefaultValue(true);
        }
    }
}
