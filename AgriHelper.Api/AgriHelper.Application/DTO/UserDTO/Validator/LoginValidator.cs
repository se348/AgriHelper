using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Application.DTO.UserDTO.Validator
{
    public class LoginValidator : AbstractValidator<LoginUserDTO>
    {
        public LoginValidator() 
        {
            RuleFor(user => user.Email)
                   .EmailAddress()
                   .WithMessage("Invalid Email");


            RuleFor(user => user.Password)
               .NotEmpty()
               .WithMessage("Password Is Required");
        }
    }
}
