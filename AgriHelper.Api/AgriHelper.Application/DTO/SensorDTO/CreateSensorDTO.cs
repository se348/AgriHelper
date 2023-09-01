
namespace AgriHelper.Application.DTO.SensorDTO
{
    public class CreateSensorDTO
    {
        public int FieldId { get; set; }
        public string SensorNo { get; set; }

        public int OptimalGDD { get; set; }

        public DateTime? CuttingDatCalculated { get; set; }

        public double Longitude { get; set; }

        public double Latitude { get; set; }

    }
}
