﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Entities
{
    public class Localidad
    {
        public int Id { get; set; }
        public string Nombre { get; set; } = null!;
        public string? Direccion { get; set; }
        public string? CodigoPostal { get; set; }

    }
}



