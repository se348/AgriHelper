using AgriHelper.Application.Contracts.Persistance;
using FluentValidation;

namespace AgriHelper.Application.DTO.UserDTO.Validator
{
    public class CreateUserDTOValidator : AbstractValidator<CreateUserDTO>
    {

        public CreateUserDTOValidator(IUserRepository userRepository)
        {
            RuleFor(user => user.Name)
                .NotEmpty()
                .WithMessage("Name Is Required")
                .MinimumLength(1)
                .WithMessage("Content Must Be at least 1");

            RuleFor(user => user.Email)
                .EmailAddress()
                .WithMessage("Invalid Email");

            RuleFor(user => user.Phone)
                .NotEmpty()
                .WithMessage("Phone Is Required")
                //.Matches(@"^[+]{1}(?:[0-9\-\(\)\/\.]\s?){6, 15}[0-9]{1}$")
                .WithMessage("Invalid phone number Format");

            RuleFor(user => user.Password)
               .NotEmpty()
               .WithMessage("Password Is Required");

            RuleFor(user => user.Email)
                .MustAsync(async (email, cancellation) =>
                {
                    var existingUser = await userRepository.GetUserByEmail(email);
                    return existingUser == null;
                })
                .WithMessage("Email already exists");
           
        }

    }
}
