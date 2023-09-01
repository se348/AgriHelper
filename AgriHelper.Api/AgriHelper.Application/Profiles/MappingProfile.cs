using AgriHelper.Application.DTO.FarmDTO;
using AgriHelper.Application.DTO.FieldDTO;
using AgriHelper.Application.DTO.SensorDTO;
using AgriHelper.Application.DTO.UserDTO;
using AgriHelper.Core.Models;

namespace AgriHelper.Application.Profiles
{
    public class MappingProfile : AutoMapper.Profile
    {

        public MappingProfile()
        {

            CreateMap<User, CreateUserDTO>().ReverseMap();
            CreateMap<Farm, CreateFarmDTO>().ReverseMap();
            CreateMap<Field, CreateFieldDTO>().ReverseMap();
            CreateMap<Sensor, CreateSensorDTO>().ReverseMap();
        }

    }
}
