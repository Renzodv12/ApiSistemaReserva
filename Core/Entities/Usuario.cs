﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Entities
{
    public class Usuario
    {
        public int Id { get; set; }
        public string Nombre { get; set; } = null!;
        public string Apellido { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string Contraseña { get; set; } = null!;
        public DateTime FechaRegistro { get; set; } = DateTime.Now;
        public bool Activo { get; set; } = true;

    }
}
