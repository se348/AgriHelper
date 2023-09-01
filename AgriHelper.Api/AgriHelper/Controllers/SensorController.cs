using AgriHelper.Application.DTO.FieldDTO;
using AgriHelper.Application.DTO.SensorDTO;
using AgriHelper.Application.Features.Field.Request.Commands;
using AgriHelper.Application.Features.Sensor.Request.Commands;
using AgriHelper.Application.Responses;
using AgriHelper.Middleware;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace AgriHelper.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SensorController : ControllerBase
    {
        private readonly IMediator _mediator;

        public SensorController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpPost]
        public async Task<IActionResult> CreateSensor(CreateSensorDTO sensorDTO)
        {
            var command = new CreateSensorCommand { CreateSensorDTO = sensorDTO };
            BaseCommandResponse<int> sensorId = await _mediator.Send(command);

            return ResponseHandler<int>.HandleResponse(sensorId, 201);
        }
    }
}
