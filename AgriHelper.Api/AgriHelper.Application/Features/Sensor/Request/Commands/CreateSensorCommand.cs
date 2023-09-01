using AgriHelper.Application.DTO.SensorDTO;
using AgriHelper.Application.Responses;
using MediatR;

namespace AgriHelper.Application.Features.Sensor.Request.Commands
{
    public class CreateSensorCommand : IRequest<BaseCommandResponse<int>>
    {
        public CreateSensorDTO CreateSensorDTO{ get; set; }
    }
}
