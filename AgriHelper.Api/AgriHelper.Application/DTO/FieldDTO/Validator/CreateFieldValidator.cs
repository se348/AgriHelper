using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Application.DTO.FarmDTO;
using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Application.DTO.FieldDTO.Validator
{
    public class CreateFieldValidator : AbstractValidator<CreateFieldDTO>
    {
        public CreateFieldValidator(IFarmRepository farmRepository)
        {
            RuleFor(field => field.Altitude)
                .NotNull()
                .WithMessage("Altitude is required");

            RuleFor(field => field.Polygon)
                .NotEmpty()
                .WithMessage("Polygon Is Required")
                .WithMessage("Polygon Must Be at least 2");

            RuleFor(field => field.FarmId)
                .MustAsync(async (farmId, cancellation) =>
                {
                    var existingFarm = await farmRepository.Get(farmId);
                    return existingFarm != null;
                })
                .WithMessage("Farm does not exist");
          
        }
    }
}
