using AgriHelper.Application.DTO.UserDTO;
using AgriHelper.Application.Model;
using AgriHelper.Application.Responses;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Application.Features.User.Request.Queries
{
    public class LoginUserQuery : IRequest<BaseCommandResponse<AuthResponse>>
    {
        public LoginUserDTO LoginUser { get; set; }
    }
}
