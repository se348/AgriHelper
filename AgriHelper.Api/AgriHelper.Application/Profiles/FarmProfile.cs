using AgriHelper.Application.DTO.FarmDTO;
using AgriHelper.Application.DTO.FieldDTO;
using AgriHelper.Application.DTO.UserDTO;
using AgriHelper.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Application.Profiles
{
    public class FarmProfile : AutoMapper.Profile
    {
        public FarmProfile()
        {

            CreateMap<Farm, FarmResponseDTO>();


            
            CreateMap<FarmUser, FarmUserResponseDTO>()
                    .ForMember(dest => dest.Role, opt => opt.MapFrom(src => src.Role.ToString()))
                    .ForMember(dest => dest.Name, opt => opt.MapFrom(src => src.User.Name))
                    .ForMember(dest => dest.Email, opt => opt.MapFrom(src => src.User.Email))
                    .ForMember(dest => dest.Phone, opt => opt.MapFrom(src => src.User.Phone));

            CreateMap<Field, FarmFieldsResponseDTO>()
                .ForMember(dest => dest.Notifications, opt => opt.MapFrom(src => src.Notifications));
            CreateMap<Notification, FarmNotificationResponseDTO>();


        }

    }
}
