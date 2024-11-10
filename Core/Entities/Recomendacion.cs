using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Entities
{
    public class Recomendacion
    {
        public int Id { get; set; }
        public int IdUsuario { get; set; }
        public int IdCancha { get; set; }
        public string TipoRecomendacion { get; set; } = null!;
        public int Prioridad { get; set; } = 1;
        public DateTime FechaCreacion { get; set; } = DateTime.Now;

        public Usuario Usuario { get; set; } = null!;
        public Cancha Cancha { get; set; } = null!;
    }


}
