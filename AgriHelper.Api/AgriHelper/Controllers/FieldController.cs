using AgriHelper.Application.DTO.FarmDTO;
using AgriHelper.Application.DTO.FieldDTO;
using AgriHelper.Application.Features.Farm.Request.Commands;
using AgriHelper.Application.Features.Field.Request.Commands;
using AgriHelper.Application.Responses;
using AgriHelper.Middleware;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace AgriHelper.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FieldController : ControllerBase
    {
        private readonly IMediator _mediator;

        public FieldController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpPost()]
        public async Task<IActionResult> CreateFild(CreateFieldDTO fieldDTO)
        {
            var command = new CreateFieldCommand { CreateFieldDTO = fieldDTO};
            BaseCommandResponse<int> fieldId = await _mediator.Send(command);

            return ResponseHandler<int>.HandleResponse(fieldId, 201);
        }
    }
}
