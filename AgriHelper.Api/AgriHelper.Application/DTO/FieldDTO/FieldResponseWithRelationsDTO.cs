using AgriHelper.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Application.DTO.FieldDTO
{
    public class FieldResponseWithRelationsDTO
    {
        public int FieldId { get; set; }
        public int Altitude { get; set; }
        public string Polygon { get; set; }

        public ICollection<SensorResponseDTO>? Sensors { get; set; }

        public ICollection<WeatherResponseDTO>? Weathers { get; set; }

    }
    public class WeatherResponseDTO
    {
        public DateTime DayOfTheWeek { get; set; }
        public double Temperature { get; set; }
        public double Precipitation { get; set; }
    }
    public class SensorResponseDTO
    {
        public int SensorId { get; set; }

        public int FieldId { get; set; }

        public string SensorNo { get; set; }

        public DateTime? LastCommunication { get; set; }

        public int BatteryStatus { get; set; }

        public int OptimalGDD { get; set; }

        public DateTime? CuttingDatCalculated { get; set; }

        public DateTime? LastForecastDate { get; set; }

        public DateTime? LastResetDate { get; set; }

        public double Longitude { get; set; }

        public double Latitude { get; set; }

        public int BaseTemp { get; set; }

        public int State { get; set; }
        public int CalculatedGdd { get; set; }
    }
}
