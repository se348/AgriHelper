using AgriHelper.Application.Contracts.Common;
using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Application.DTO.FarmDTO.Validator;
using AgriHelper.Application.DTO.FieldDTO.Validator;
using AgriHelper.Application.Exceptions;
using AgriHelper.Application.Features.Farm.Request.Commands;
using AgriHelper.Application.Features.Field.Request.Commands;
using AgriHelper.Application.Responses;
using AgriHelper.Core.Models;
using AutoMapper;
using MediatR;

namespace AgriHelper.Application.Features.Field.Handlers
{
    public class CreateFieldCommandHandler : IRequestHandler<CreateFieldCommand, BaseCommandResponse<int>>
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IDateTimeProvider _dateTimeProvider;

        public CreateFieldCommandHandler(IUnitOfWork unitOfWork, IMapper mapper, IDateTimeProvider dateTimeProvider)
        {
            _mapper = mapper;
            _unitOfWork = unitOfWork;
            _dateTimeProvider = dateTimeProvider;
        }
        public async Task<BaseCommandResponse<int>> Handle(CreateFieldCommand request, CancellationToken cancellationToken)
        {
            try
            {
                var validator = new CreateFieldValidator(_unitOfWork.FarmRepository);
                var validationResult = await validator.ValidateAsync(request.CreateFieldDTO);

                if (!validationResult.IsValid) throw new ValidationException(validationResult);

                var field = _mapper.Map<AgriHelper.Core.Models.Field>(request.CreateFieldDTO);

                await _unitOfWork.FieldRepository.Add(field);

                await _unitOfWork.Save();

                return BaseCommandResponse<int>.SuccessHandler(field.FieldId);

            }
            catch (Exception ex)
            {
                return BaseCommandResponse<int>.FailureHandler(ex);
            }

        }
    }
}
