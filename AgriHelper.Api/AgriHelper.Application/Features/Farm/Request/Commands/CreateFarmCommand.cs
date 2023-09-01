using AgriHelper.Application.DTO.FarmDTO;
using AgriHelper.Application.Responses;
using MediatR;

namespace AgriHelper.Application.Features.Farm.Request.Commands
{
    public class CreateFarmCommand : IRequest<BaseCommandResponse<int>>
    {

        public CreateFarmDTO CreateFarmDTO { get; set; }
    }
}
