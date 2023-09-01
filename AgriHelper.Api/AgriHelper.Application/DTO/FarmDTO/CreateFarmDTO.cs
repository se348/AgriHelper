

namespace AgriHelper.Application.DTO.FarmDTO
{
    public class CreateFarmDTO
    {
        public int UserId { get; set; }
        public string Name { get; set; }
        public string PostCode { get; set; }
        public string City { get; set; }
        public string Country { get; set; }
    }
}
