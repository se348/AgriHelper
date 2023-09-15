using AgriHelper.Application.Features.SensorDateInformation.Request.Commands;
using AgriHelper.Core.Models;
using AgriHelper.Middleware;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace AgriHelper.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SensorDateInformationController : ControllerBase
    {
        private readonly IMediator _mediator;

        public SensorDateInformationController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpPost("MockSensorDataRecieved")]
        public async Task<IActionResult> CreateSensorDateInfo()
        {
            var command = new MockSensorDateInfoRecievedCommand();
            var response= await _mediator.Send(command);
            return ResponseHandler<int>.HandleResponse(response, 201);
        }

        [HttpPost("CalculateGDD")]
        public async Task<IActionResult> CalculateGdd()
        {
            var command = new CalculateGDDCommand();
            var response = await _mediator.Send(command);
            return ResponseHandler<int>.HandleResponse(response, 201);
        }

      /*  [HttpPost("ResetGdd/{fieldId}")]
        public async Task<IActionResult> ResetGdd(int fieldId)
        {

        }*/

    }
}
