using AgriHelper.Application.DTO.FarmDTO;
using AgriHelper.Application.Responses;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Application.Features.Farm.Request.Queries
{
    public class GetFarmQueries : IRequest<BaseCommandResponse<List<FarmResponseDTO>>>
    {
        public GetFarmDTO GetFarmDTO {  get; set; } 
    }
   
}
