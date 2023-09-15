using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Application.DTO.FarmDTO;
using AgriHelper.Application.Features.Farm.Request.Queries;
using AgriHelper.Application.Responses;
using AutoMapper;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Application.Features.Farm.Handlers
{
    public class GetFarmQueryHandler : IRequestHandler<GetFarmQuery, BaseCommandResponse<FarmResponseDTO>>
    {
        private IUnitOfWork _unitOfWork;
        private IMapper _mapper;
        public GetFarmQueryHandler(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
        }

        public async Task<BaseCommandResponse<FarmResponseDTO>> Handle(GetFarmQuery request, CancellationToken cancellationToken)
        {
            var farm = await _unitOfWork.FarmRepository.GetFarmWithRelations(request.FieldId);
            return BaseCommandResponse<FarmResponseDTO>.SuccessHandler(_mapper.Map<FarmResponseDTO>(farm));
        }
    }
}
