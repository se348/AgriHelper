

namespace AgriHelper.Core.Models
{
    public class User
    {
        public int UserId { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string Phone {  get; set; }
        public ICollection<SensorResetDate>? SensorResetDates { get; set; }
        public ICollection<FarmUser> FarmUsers { get; set; }
    }
}
