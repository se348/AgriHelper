using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Application.DTO.FieldDTO;
using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Application.DTO.SensorDTO.Validator
{
    public class CreateSensorValidator : AbstractValidator<CreateSensorDTO>
    {
        public CreateSensorValidator(IFieldRepository fieldRepository)
        {
            RuleFor(sensor => sensor.SensorNo)
                .NotEmpty()
                .WithMessage("Serial Number is required");

            RuleFor(sensor => sensor.Latitude)
                .NotEmpty()
                .WithMessage("Latitude Is Required");

            RuleFor(sensor => sensor.Longitude)
                    .NotEmpty()
                    .WithMessage("Longitude Is Required");

            RuleFor(sensor => sensor.OptimalGDD)
                  .NotEmpty()
                  .WithMessage("GDD Is Required");


            RuleFor(sensor => sensor.FieldId)
                .MustAsync(async (fieldId, cancellation) =>
                {
                    var existingField = await fieldRepository.Get(fieldId
                        );
                    return existingField != null;
                })
                .WithMessage("Field does not exist");

            RuleFor(field => field.BaseTemp)
              .NotEmpty()
              .LessThanOrEqualTo(30)
              .GreaterThanOrEqualTo(10);

        }
    }
}
