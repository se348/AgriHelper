using AgriHelper.Application.Contracts.Common;
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
    public class GetFieldWithSensorQueryHandler : IRequestHandler<GetFieldWithSensorQuery, BaseCommandResponse<FieldResponseWithRelationsDTO>>
    {

        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IDateTimeProvider _dateTimeProvider;
        public GetFieldWithSensorQueryHandler(IUnitOfWork unitOfWork, IMapper mapper, IDateTimeProvider dateTimeProvider)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _dateTimeProvider = dateTimeProvider;
        }

        public async Task<BaseCommandResponse<FieldResponseWithRelationsDTO>> Handle(GetFieldWithSensorQuery request, CancellationToken cancellationToken)
        {
            var field = await _unitOfWork.FieldRepository.GetWithRelations(request.FieldId);

            DateTime currentDateNow = (DateTime)_dateTimeProvider.DateUTCNow;
            DateTime currentDate = new DateTime(currentDateNow.Year, currentDateNow.Month, currentDateNow.Day, 0, 0, 0);
            DateTime next_6_days = currentDate.AddDays(6);

            Dictionary<DateTime, double> tempMapping = new Dictionary<DateTime, double>();
            Dictionary<DateTime, double> precipitaionMapping = new Dictionary<DateTime, double>();

            double n = field.Sensors.Count;
            foreach (var sensor in field.Sensors)
            {
                var sensorDateInformation = await _unitOfWork.SensorDateInformationRepository.GetSensorInformation(sensor.SensorId, currentDate, next_6_days);

                foreach(var dateInfo  in sensorDateInformation)
                {
                    if (tempMapping.ContainsKey(dateInfo.DateTime.Value))
                    {
                        tempMapping[dateInfo.DateTime.Value] += (dateInfo.AvgTemp / n);
                        precipitaionMapping[dateInfo.DateTime.Value] += (dateInfo.PrecipitationInMMs / n);
                    }
                    else
                    {
                        tempMapping[dateInfo.DateTime.Value] = (dateInfo.AvgTemp / n);
                        precipitaionMapping[dateInfo.DateTime.Value] = (dateInfo.PrecipitationInMMs / n);
                    }
                   
                }
            }
            List<WeatherResponseDTO> weatherResponseDTOs = new List<WeatherResponseDTO>();

            foreach (KeyValuePair<DateTime, double> kvp in tempMapping)
            {
                var key = kvp.Key;
                var weatherResponseDto = new WeatherResponseDTO() { DayOfTheWeek = key, Precipitation = precipitaionMapping[key], Temperature = kvp.Value };
                weatherResponseDTOs.Add(weatherResponseDto);
            }

            var response = _mapper.Map<FieldResponseWithRelationsDTO>(field);
            response.Weathers = weatherResponseDTOs;

            return BaseCommandResponse<FieldResponseWithRelationsDTO>.SuccessHandler(response);
        }
    }
}
