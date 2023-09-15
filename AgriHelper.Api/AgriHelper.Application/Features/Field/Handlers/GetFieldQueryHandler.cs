using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Application.DTO.FieldDTO;
using AgriHelper.Application.Features.Field.Request.Queries;
using AgriHelper.Application.Responses;
using AutoMapper;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Application.Features.Field.Handlers
{
    public class GetFieldQueryHandler : IRequestHandler<GetFieldQuery, BaseCommandResponse<FieldResponseDTO>>
    {
        private readonly IMapper mapper;
        private readonly IUnitOfWork unitOfWork;

        public GetFieldQueryHandler(IMapper mapper, IUnitOfWork unitOfWork)
        {
            this.mapper = mapper;
            this.unitOfWork = unitOfWork;
        }

        public async Task<BaseCommandResponse<FieldResponseDTO>> Handle(GetFieldQuery request, CancellationToken cancellationToken)
        {
            var field = await unitOfWork.FieldRepository.GetWithRelations(request.FieldId);
            return BaseCommandResponse<FieldResponseDTO>.SuccessHandler(mapper.Map<FieldResponseDTO>(field));
        }
    }
}
