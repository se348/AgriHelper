using AgriHelper.Application.DTO.FarmDTO;
using AgriHelper.Application.DTO.UserDTO;
using AgriHelper.Application.Features.Farm.Request.Queries;
using AgriHelper.Application.Features.User.Request.Commands;
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

        public UserController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpPost]
        public async Task<IActionResult> CreateUser(CreateUserDTO userDto)
        {
            var command = new CreateUserCommand { CreateUserDTO = userDto };
            BaseCommandResponse<int> userId = await _mediator.Send(command);

            return ResponseHandler<int>.HandleResponse(userId, 201);
        }

        [HttpGet("MyFarms")]
        public async Task<IActionResult> GetFarms([FromQuery] GetFarmDTO getFarmDTO)
        {
            var query = new GetFarmQueries { GetFarmDTO = getFarmDTO };
            BaseCommandResponse<List<FarmResponseDTO>> farms = await _mediator.Send(query);

            return ResponseHandler<List<FarmResponseDTO>>.HandleResponse(farms, 200);
        }
    }
}
