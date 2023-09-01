using AgriHelper.Application.DTO.FarmDTO;
using AgriHelper.Core.Models;

namespace AgriHelper.Application.DTO.FarmDTO
{

    public class FarmUserResponseDTO
    {
        public int UserId { get; set; }
        public string Name { get;set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Role { get; set; }

        public DateTime? Timestamp { get; set; }

        public bool RecieveNotifications { get; set; }
    }


    public class FarmNotificationResponseDTO
    {
        public int NotificationId { get; set; }
        public string Title { get; set; }
        public string Message { get; set; }
        public int SendBy { get; set; }
        public int Status { get; set; }
    }

    public class FarmFieldsResponseDTO
    {
        public int FieldId { get; set; }
        public int Altitude { get; set; }
        public string Polygon { get; set; }

    }
    public class FarmResponseDTO
    {
        public int FarmId { get; set; }
        public string Name { get; set; }
        public string PostCode { get; set; }
        public string City { get; set; }
        public string Country { get; set; }

        public ICollection<FarmUserResponseDTO>? Users { get; set; }

        public ICollection<FarmNotificationResponseDTO>? Notifications { get; set; }

        public ICollection<FarmFieldsResponseDTO> Fields { get; set; }
    }
}
