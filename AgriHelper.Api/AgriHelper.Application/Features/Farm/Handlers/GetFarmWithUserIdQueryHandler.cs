using AgriHelper.Application.Contracts.Common;
using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Application.DTO.FarmDTO;
using AgriHelper.Application.DTO.FarmDTO.Validator;
using AgriHelper.Application.Features.Farm.Request.Commands;
using AgriHelper.Application.Features.Farm.Request.Queries;
using AgriHelper.Application.Responses;
using AgriHelper.Core.Models;
using AutoMapper;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Application.Features.Farm.Handlers
{
    public class GetFarmWithUserIdQueryHandler : IRequestHandler<GetFarmWithUserIdQueries, BaseCommandResponse<List<FarmResponseDTO>>>
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IDateTimeProvider _dateTimeProvider;

        public GetFarmWithUserIdQueryHandler(IUnitOfWork unitOfWork, IMapper mapper, IDateTimeProvider dateTimeProvider)
        {
            _mapper = mapper;
            _unitOfWork = unitOfWork;
            _dateTimeProvider = dateTimeProvider;
        }
        public async Task<BaseCommandResponse<List<FarmResponseDTO>>> Handle(GetFarmWithUserIdQueries request, CancellationToken cancellationToken)
        {
            try
            {


                var farms = await _unitOfWork.FarmRepository.GetFarmWithUserId(request.GetFarmDTO.UserId);
                return BaseCommandResponse<List<FarmResponseDTO>>.SuccessHandler(_mapper.Map<List<FarmResponseDTO>>(farms));

            }
            catch (Exception ex)
            {
                return BaseCommandResponse<List<FarmResponseDTO>>.FailureHandler(ex);
            }

        }
    }
}
