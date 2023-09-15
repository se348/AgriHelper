using AgriHelper.Application.Contracts.Common;
using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Application.Features.Field.Request.Commands;
using AgriHelper.Application.Features.SensorDateInformation.Request.Commands;
using AgriHelper.Application.Responses;
using AgriHelper.Core.Models;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Application.Features.SensorDateInformation.Handlers
{
    public class MockSensorDateInfoRecievedCommandHandler : IRequestHandler<MockSensorDateInfoRecievedCommand, BaseCommandResponse<int>>
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IDateTimeProvider _dateTimeProvider;

        public MockSensorDateInfoRecievedCommandHandler(IUnitOfWork unitOfWork, IDateTimeProvider dateTimeProvider)
        {
            _unitOfWork = unitOfWork;
            _dateTimeProvider = dateTimeProvider;
        }
        public async Task<BaseCommandResponse<int>> Handle(MockSensorDateInfoRecievedCommand request, CancellationToken cancellationToken)
        {
            var sensors = await _unitOfWork.SensorRepository.GetAll();
            var originalYesteday = _dateTimeProvider.DateUTCNow.Value.AddDays(-1);
            var midNightYesterday = new DateTime(originalYesteday.Year, originalYesteday.Month, originalYesteday.Day, 0, 0, 0);
            Random random = new Random();
            
            foreach (var sensor in sensors)
            {
                var currentDate = midNightYesterday;
                for (int i = 0; i < 10; i++)
                {
                    var sensorDateInformation = await _unitOfWork.SensorDateInformationRepository.GetBySensorIdAndDate(sensor.SensorId, currentDate);
                    if (sensorDateInformation != null)
                    {
                        var avgTemp = random.Next(20, 31);
                        var gddAddition = avgTemp - sensor.BaseTemp;
                        sensorDateInformation.AvgTemp = avgTemp;
                        sensorDateInformation.GddAddition = gddAddition;
                        sensorDateInformation.PrecipitationInMMs = random.NextDouble() * 10;
                        await _unitOfWork.SensorDateInformationRepository.Update(sensorDateInformation);
                    }
                    else
                    {
                        var avgTemp = random.Next(20, 31);
                        var gddAddition = avgTemp - sensor.BaseTemp;
                        var precipitationInMMs = random.NextDouble() * 10;
                        var sensorDateInfo = new AgriHelper.Core.Models.SensorDateInformation() { DateTime = currentDate, SensorId = sensor.SensorId, AvgTemp = avgTemp, GddAddition = gddAddition, PrecipitationInMMs = precipitationInMMs };
                        await _unitOfWork.SensorDateInformationRepository.Add(sensorDateInfo);

                    }
                    currentDate = currentDate.AddDays(1);
                }

                sensor.BatteryStatus = random.Next(0, 5);
                if (sensor.BatteryStatus == 0)
                {
                    var notification = new Notification() { FieldId = sensor.FieldId, SendBy = sensor.SensorId, Status = NotificationTypes.WARNING, Message = $"Battery low on sensor {sensor.SensorNo}", Timestamp= _dateTimeProvider.DateUTCNow ?? DateTime.Now, Title= "Battery Status" };
                    await _unitOfWork.NotificationRepository.Add(notification);
                }
                await _unitOfWork.SensorRepository.Update(sensor);
               
            
            }
            await _unitOfWork.Save();

            return BaseCommandResponse<int>.SuccessHandler(1); 

        }
    }
}
