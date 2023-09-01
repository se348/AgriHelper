
namespace AgriHelper.Core.Models
{
    public class Sensor
    {
        public int SensorId { get; set; }

        public int FieldId { get; set; }
        public Field? Field { get; set; }

        public string SensorNo { get; set; }

        public DateTime? LastCommunication { get; set; }

        public int BatteryStatus { get; set; }

        public int OptimalGDD { get; set; }

        public DateTime? CuttingDatCalculated { get; set; }

        public DateTime? LastForecastDate { get; set; }

        public double Longitude { get; set; }

        public double Latitude { get; set; }

        public int State { get; set; }

        public ICollection<SensorResetDate>? ResetDates { get; set; }
    }
}
