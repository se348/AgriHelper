
namespace AgriHelper.Core.Models
{
    public class SensorResetDate
    {

        public int Id { get; set; }

        public int SensorId { get; set; }
        public Sensor? Sensor { get; set; }
        public DateTime Timestamp { get; set; }

        public int UserId { get; set; }

        public User? User { get; set; }
    }
}
