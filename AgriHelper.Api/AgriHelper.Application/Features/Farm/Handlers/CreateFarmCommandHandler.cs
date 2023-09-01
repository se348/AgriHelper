
using AgriHelper.Application.Contracts.Common;
using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Application.DTO.FarmDTO.Validator;
using AgriHelper.Application.Exceptions;
using AgriHelper.Application.Features.Farm.Request.Commands;
using AgriHelper.Application.Responses;
using AgriHelper.Core.Models;
using AutoMapper;
using MediatR;

namespace AgriHelper.Application.Features.Farm.Handlers
{
    public class CreateFarmCommandHandler : IRequestHandler<CreateFarmCommand, BaseCommandResponse<int>>
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IDateTimeProvider _dateTimeProvider;

        public CreateFarmCommandHandler(IUnitOfWork unitOfWork, IMapper mapper, IDateTimeProvider dateTimeProvider)
        {
            _mapper = mapper;
            _unitOfWork = unitOfWork;
            _dateTimeProvider = dateTimeProvider;
        }
        public async Task<BaseCommandResponse<int>> Handle(CreateFarmCommand request, CancellationToken cancellationToken)
        {
            try
            {
                var validator = new CreateFarmValidator(_unitOfWork.UserRepository);
                var validationResult = await validator.ValidateAsync(request.CreateFarmDTO);

                if (!validationResult.IsValid) throw new ValidationException(validationResult);

                var farm = _mapper.Map<AgriHelper.Core.Models.Farm>(request.CreateFarmDTO);

                await _unitOfWork.FarmRepository.Add(farm);

                await _unitOfWork.Save();


                var farmUser = new FarmUser() { FarmId = farm.FarmId, UserId = request.CreateFarmDTO.UserId, Role = Role.OWNER, RecieveNotifications = true, Timestamp = _dateTimeProvider.DateUTCNow };
                await _unitOfWork.FarmUserRepository.Add(farmUser);
                await _unitOfWork.Save();

                return BaseCommandResponse<int>.SuccessHandler(farm.FarmId);

            }
            catch (Exception ex)
            {
                return BaseCommandResponse<int>.FailureHandler(ex);
            }

        }
    }
}
