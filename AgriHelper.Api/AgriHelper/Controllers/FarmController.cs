using AgriHelper.Application.DTO.FarmDTO;
using AgriHelper.Application.Features.Farm.Request.Commands;
using AgriHelper.Application.Responses;
using AgriHelper.Middleware;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace AgriHelper.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FarmController : ControllerBase
    {
        private readonly IMediator _mediator;

        public FarmController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpPost()]
        public async Task<IActionResult> CreateFarm(CreateFarmDTO farmDTO)
        {
            var command = new CreateFarmCommand { CreateFarmDTO = farmDTO };
            BaseCommandResponse<int> farmId = await _mediator.Send(command);

            return ResponseHandler<int>.HandleResponse(farmId, 201);
        }
    }
}
