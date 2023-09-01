using AgriHelper.Application.Contracts.Persistance;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FluentValidation;

namespace AgriHelper.Application.DTO.FarmDTO.Validator
{
    public class CreateFarmValidator : AbstractValidator<CreateFarmDTO>
    {
        public CreateFarmValidator(IUserRepository userRepository)
        {
            RuleFor(farm => farm.Name)
                .NotEmpty()
                .WithMessage("Name Is Required")
                .MinimumLength(1)
                .WithMessage("Content Must Be at least 2");

            RuleFor(farm => farm.City)
                .NotEmpty()
                .WithMessage("City Is Required")
                .MinimumLength(2)
                .WithMessage("City Must Be at least 2");

            RuleFor(farm => farm.PostCode)
                .NotEmpty()
                .WithMessage("PostCode Is Required");

            RuleFor(farm => farm.Country)
              .NotEmpty()
              .WithMessage("Country Is Required");

            RuleFor(farm => farm.UserId)
                .MustAsync(async (userId, cancellation) =>
                {
                    var existingUser = await userRepository.Get(userId);
                    return existingUser != null;
                })
                .WithMessage("User does not exist");

        }
    }
}
