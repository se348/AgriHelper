
namespace AgriHelper.Core.Models
{
    public class Notification
    {
        public int NotificationId { get; set; }
        public string Title { get; set; }
        public string Message { get; set; }
        public int SendBy { get; set; }
        public int Status { get; set; }
        public int FarmId { get; set; }

        public Farm? Farm { get; set; }
    }
}
