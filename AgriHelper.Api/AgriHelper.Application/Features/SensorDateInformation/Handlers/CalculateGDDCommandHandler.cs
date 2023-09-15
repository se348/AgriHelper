using AgriHelper.Application.Contracts.Common;
using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Application.Features.SensorDateInformation.Request.Commands;
using AgriHelper.Application.Responses;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Application.Features.SensorDateInformation.Handlers
{
    public class CalculateGDDCommandHandler : IRequestHandler<CalculateGDDCommand, BaseCommandResponse<int>>
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IDateTimeProvider _dateTimeProvider;

        public CalculateGDDCommandHandler(IUnitOfWork unitOfWork, IDateTimeProvider dateTimeProvider)
        {
            _unitOfWork = unitOfWork;
            _dateTimeProvider = dateTimeProvider;
        }

        public async Task<BaseCommandResponse<int>> Handle(CalculateGDDCommand request, CancellationToken cancellationToken)
        {
            var sensors  = await _unitOfWork.SensorRepository.GetAll();
            foreach(var sensor in sensors)
            {
                var sensorDateInformations = await _unitOfWork.SensorDateInformationRepository.GetSensorInformation(sensor.SensorId, sensor.LastResetDate);
                double computedGddTillToday = 0;
                double computedGddTill9DaysAfterNow = 0;
                bool cond = false;

                foreach(var sensorDate in sensorDateInformations)
                {
                    if(sensorDate.DateTime <= _dateTimeProvider.DateUTCNow)
                    {
                        computedGddTillToday += sensorDate.GddAddition;
                        if(computedGddTillToday >= sensor.OptimalGDD && cond == false)
                        {
                            sensor.CuttingDatCalculated = sensorDate.DateTime;
                            cond = true;
                        }
                    }
                    else
                    {
                        if(computedGddTill9DaysAfterNow == 0)
                        {
                            computedGddTill9DaysAfterNow = computedGddTillToday;
                        }
                        computedGddTill9DaysAfterNow += sensorDate.GddAddition;
                        if (computedGddTill9DaysAfterNow >= sensor.OptimalGDD && cond == false)
                        {
                            sensor.CuttingDatCalculated = sensorDate.DateTime;
                            cond = true;
                        }
                    }
                }
                sensor.CalculatedGdd = ((int)computedGddTillToday);
                await _unitOfWork.SensorRepository.Update(sensor);

            }
            await _unitOfWork.Save();
            return BaseCommandResponse<int>.SuccessHandler(1);
        }
    }
}
