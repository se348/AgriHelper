
namespace AgriHelper.Core.Models
{
    public class Farm
    {

        public int FarmId { get; set; }
        public string Name { get; set;}
        public string PostCode { get; set; }
        public string City { get; set; }
        public string Country { get; set; } 

        public ICollection<FarmUser>? FarmUsers { get; set; }

        public ICollection<Field> Fields { get; set; }

    }
}
