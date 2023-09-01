using AgriHelper.Application.DTO.FieldDTO;
using AgriHelper.Application.Responses;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Application.Features.Field.Request.Commands
{
    public class CreateFieldCommand : IRequest<BaseCommandResponse<int>>
    {
        public CreateFieldDTO CreateFieldDTO { get; set; }
    }
}
