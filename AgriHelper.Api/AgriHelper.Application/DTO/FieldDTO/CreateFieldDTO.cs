using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Application.DTO.FieldDTO
{
    public class CreateFieldDTO
    {
        public int FarmId { get; set; }
        public int Altitude { get; set; }
        public string Polygon { get; set; }

    }
}
