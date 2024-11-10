using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Models
{
    public class ReservaData
    {
        public int UserId { get; set; }
        public int CanchaId { get; set; }
        public float Price { get; set; }
        public float Hour { get; set; }
        public float LocalidadId { get; set; }
        public float Capacity { get; set; }
        public float Rating { get; set; }
        }
        public class ReservaPrediction
    {
        public float Score { get; set; }
    }

}
