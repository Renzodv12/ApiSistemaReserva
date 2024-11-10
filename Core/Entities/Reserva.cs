using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Entities
{
    public class Reserva
    {
        public int Id { get; set; }
        public int IdUsuario { get; set; }
        public int IdCancha { get; set; }
        public DateTime FechaHoraInicio { get; set; }
        public DateTime FechaHoraFin { get; set; }
        public decimal PrecioTotal { get; set; }
        public string Estado { get; set; } = null!;
        public Usuario Usuario { get; set; } = null!;
        public Cancha Cancha { get; set; } = null!;
    }

}
