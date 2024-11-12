using Core.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infraestructura.DBContext.Configurations
{
    public class HorarioConfiguration : IEntityTypeConfiguration<Horario>
    {
        public void Configure(EntityTypeBuilder<Horario> builder)
        {
            builder.ToTable("horario");

            builder.HasKey(h => h.Id);

            builder.Property(h => h.Id)
                .HasColumnName("id");
         
            builder.Property(h => h.Fecha)
                .HasColumnName("fecha")
                .IsRequired();

            builder.Property(h => h.HoraInicio)
                .HasColumnName("horainicio")
                .IsRequired();

            builder.Property(h => h.HoraFin)
                .HasColumnName("horafin")
                .IsRequired();

            builder.Property(h => h.CanchaId)
                .HasColumnName("canchaid");
        }
    }
}
