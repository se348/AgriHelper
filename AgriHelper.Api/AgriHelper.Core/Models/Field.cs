

namespace AgriHelper.Core.Models
{
    public class Field
    {
        public int FieldId { get; set; }
        public int FarmId { get; set; }
        public Farm? Farm { get; set; }
        public int Altitude { get; set; }
        public string Polygon { get; set; }

        public ICollection<Sensor>? Sensors { get; set; }    

        public ICollection<Notification>? Notifications { get; set; }
    }
}
