using AgriHelper.Application.DTO.FieldDTO;
using AgriHelper.Core.Models;
using AutoMapper;

namespace AgriHelper.Application.Profiles
{
    public class FieldProfile:AutoMapper.Profile
    {
        public FieldProfile()
        {

            CreateMap<Field, FieldResponseDTO>()
                .ForMember(dest => dest.Notifications, opt => opt.MapFrom(src => src.Notifications));
            CreateMap<Notification, FieldNotificationResponseDTO>();


            CreateMap<Field, FieldResponseWithRelationsDTO>()
             .ForMember(dest => dest.Sensors, opt => opt.MapFrom(src => src.Sensors));

            CreateMap<Sensor, SensorResponseDTO>();
        }
    }
}
