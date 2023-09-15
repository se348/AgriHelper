

namespace AgriHelper.Application.DTO.FieldDTO
{
    public class FieldResponseDTO
    {
        public int FieldId { get; set; }
        public int Altitude { get; set; }
        public string Polygon { get; set; }

        public int BaseTemp { get; set; }

        public List<FieldNotificationResponseDTO> Notifications { get; set; }
    }

    


    public class FieldNotificationResponseDTO
    {
        public int NotificationId { get; set; }
        public string Title { get; set; }
        public string Message { get; set; }
        public int SendBy { get; set; }
        public DateTime Timestamp { get; set; }
        public int Status { get; set; }
    }

  
   
}
