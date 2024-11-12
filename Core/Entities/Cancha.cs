using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Entities
{
    public class Cancha
    {
        public int Id { get; set; }
        public string Nombre { get; set; } = null!;
        public int Capacidad { get; set; }
        public decimal PrecioPorHora { get; set; }
        public int DeporteId { get; set; }
        public int IdLocalidad { get; set; }

        public Deporte Deporte { get; set; } = null!;
        public Localidad Localidad { get; set; } = null!;
         public ICollection<Horario> Horarios { get; set; } = new List<Horario>();
      

    }
}

