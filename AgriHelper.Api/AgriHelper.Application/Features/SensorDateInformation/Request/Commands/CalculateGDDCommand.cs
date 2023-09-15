using AgriHelper.Application.Responses;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Application.Features.SensorDateInformation.Request.Commands
{
    public class CalculateGDDCommand : IRequest<BaseCommandResponse<int>>
    {

    }
}
