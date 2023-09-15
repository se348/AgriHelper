using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Application.DTO.FarmDTO;
using AgriHelper.Application.DTO.UserDTO;
using AgriHelper.Application.Features.Farm.Request.Queries;
using AgriHelper.Application.Features.User.Request.Commands;
using AgriHelper.Application.Features.User.Request.Queries;
using AgriHelper.Application.Model;
using AgriHelper.Application.Responses;
using AgriHelper.Middleware;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace AgriHelper.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IMediator _mediator;
        private readonly IDbInitializer dbInitializer;

        public UserController(IMediator mediator, IDbInitializer dbInitializer)
        {
            _mediator = mediator;
            this.dbInitializer = dbInitializer;
        }

        [HttpPost]
        public async Task<IActionResult> CreateUser(CreateUserDTO userDto)
        {
            var command = new CreateUserCommand { CreateUserDTO = userDto };
            BaseCommandResponse<AuthResponse> userResponse = await _mediator.Send(command);

            return ResponseHandler<AuthResponse>.HandleResponse(userResponse, 201);
        }

        [HttpPost("Login")]
        public async Task<IActionResult> LoginUser(LoginUserDTO userDto)
        {
            var quey = new LoginUserQuery { LoginUser = userDto };
            BaseCommandResponse<AuthResponse> userResponse = await _mediator.Send(quey);

            return ResponseHandler<AuthResponse>.HandleResponse(userResponse, 200);
        }

        [HttpGet("MyFarms")]
        public async Task<IActionResult> GetFarms([FromQuery] GetFarmWIthUserIdDTO getFarmDTO)
        {
            var query = new GetFarmWithUserIdQueries { GetFarmDTO = getFarmDTO };
            BaseCommandResponse<List<FarmResponseDTO>> farms = await _mediator.Send(query);

            return ResponseHandler<List<FarmResponseDTO>>.HandleResponse(farms, 200);
        }

        [HttpPost("Initialize")]
        public async Task<IActionResult> Initialize()
        {
            await dbInitializer.Initialize();
            return ResponseHandler<int>.HandleResponse(BaseCommandResponse<int>.SuccessHandler(1), 200);
        }
    }
}
