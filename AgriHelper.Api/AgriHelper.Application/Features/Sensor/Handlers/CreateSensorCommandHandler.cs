using AgriHelper.Application.Contracts.Common;
using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Application.DTO.FieldDTO.Validator;
using AgriHelper.Application.DTO.SensorDTO.Validator;
using AgriHelper.Application.Exceptions;
using AgriHelper.Application.Features.Field.Request.Commands;
using AgriHelper.Application.Features.Sensor.Request.Commands;
using AgriHelper.Application.Responses;
using AutoMapper;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Application.Features.Sensor.Handlers
{
    public class CreateSensorCommandHandler : IRequestHandler<CreateSensorCommand, BaseCommandResponse<int>>
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IDateTimeProvider _dateTimeProvider;

        public CreateSensorCommandHandler(IUnitOfWork unitOfWork, IMapper mapper, IDateTimeProvider dateTimeProvider)
        {
            _mapper = mapper;
            _unitOfWork = unitOfWork;
            _dateTimeProvider = dateTimeProvider;
        }
        public async Task<BaseCommandResponse<int>> Handle(CreateSensorCommand request, CancellationToken cancellationToken)
        {
            try
            {
                var validator = new CreateSensorValidator(_unitOfWork.FieldRepository);
                var validationResult = await validator.ValidateAsync(request.CreateSensorDTO);

                if (!validationResult.IsValid) throw new ValidationException(validationResult);

                var sensor = _mapper.Map<AgriHelper.Core.Models.Sensor>(request.CreateSensorDTO);

                sensor.BatteryStatus = 1;
                sensor.State = 1;
                await _unitOfWork.SensorRepository.Add(sensor);

                await _unitOfWork.Save();

                return BaseCommandResponse<int>.SuccessHandler(sensor.SensorId);

            }
            catch (Exception ex)
            {
                return BaseCommandResponse<int>.FailureHandler(ex);
            }

        }
    }
}
