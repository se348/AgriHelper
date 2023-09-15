using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Core.Models
{
    public class SensorDateInformation
    {
        public int Id { get; set; }
        public DateTime? DateTime { get; set; }
        public int SensorId { get; set; }
        public Sensor? Sensor { get; set; }
        public double AvgTemp { get; set; } 
        public double GddAddition { get; set; }
        public double PrecipitationInMMs { get; set; }
    }
}
