using AgriHelper.Application.DTO.FarmDTO;
using AgriHelper.Application.DTO.FieldDTO;
using AgriHelper.Application.Features.Farm.Request.Commands;
using AgriHelper.Application.Features.Field.Request.Commands;
using AgriHelper.Application.Features.Field.Request.Queries;
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

        [HttpPost]
        public async Task<IActionResult> CreateFild(CreateFieldDTO fieldDTO)
        {
            var command = new CreateFieldCommand { CreateFieldDTO = fieldDTO};
            BaseCommandResponse<int> fieldId = await _mediator.Send(command);

            return ResponseHandler<int>.HandleResponse(fieldId, 201);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetField(int id)
        {
            var query = new GetFieldQuery { FieldId = id };
            BaseCommandResponse<FieldResponseDTO> field = await _mediator.Send(query);
            return ResponseHandler<FieldResponseDTO>.HandleResponse(field, 200);
        }

        [HttpGet("{id}/WithSensors")]
        public async Task<IActionResult> GetFieldWithSensors(int id)
        {
            var query = new GetFieldWithSensorQuery { FieldId = id };
            BaseCommandResponse<FieldResponseWithRelationsDTO> field = await _mediator.Send(query);
            return ResponseHandler<FieldResponseWithRelationsDTO>.HandleResponse(field, 200);
        }
    }
}
