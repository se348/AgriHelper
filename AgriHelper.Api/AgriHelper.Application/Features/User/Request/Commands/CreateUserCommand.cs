using AgriHelper.Application.DTO.UserDTO;
using AgriHelper.Application.Model;
using AgriHelper.Application.Responses;
using MediatR;

namespace AgriHelper.Application.Features.User.Request.Commands
{
    public class CreateUserCommand: IRequest<BaseCommandResponse<AuthResponse>>
    {

        public CreateUserDTO CreateUserDTO { get; set; }
    }
}
