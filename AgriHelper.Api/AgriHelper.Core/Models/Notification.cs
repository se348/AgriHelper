
namespace AgriHelper.Core.Models
{
    public enum NotificationTypes
    {
        WARNING, ERROR, INFO
    }
    public class Notification
    {
        public int NotificationId { get; set; }
        public string Title { get; set; }
        public string Message { get; set; }
        public int SendBy { get; set; }
        public NotificationTypes Status { get; set; }
        public int FieldId { get; set; }
        public DateTime Timestamp { get; set; }

        public Field? Field { get; set; }
    }
}
