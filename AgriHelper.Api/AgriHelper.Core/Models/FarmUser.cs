
namespace AgriHelper.Core.Models
{
    public enum Role
    {
        OWNER
    }
    public class FarmUser
    {
        public int Id { get; set; } 
        public int UserId { get; set; }
        public int FarmId { get; set; }

        public User? User { get; set; }
        public Farm? Farm { get; set; }

        public Role Role { get; set; }

        public DateTime? Timestamp { get; set; }

        public bool RecieveNotifications { get; set; }
    }
}
