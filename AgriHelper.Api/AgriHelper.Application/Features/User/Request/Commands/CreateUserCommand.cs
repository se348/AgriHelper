using AgriHelper.Application.DTO.UserDTO;
using AgriHelper.Application.Responses;
using MediatR;

namespace AgriHelper.Application.Features.User.Request.Commands
{
    public class CreateUserCommand: IRequest<BaseCommandResponse<int>>
    {

        public CreateUserDTO CreateUserDTO { get; set; }
    }
}
