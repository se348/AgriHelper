using AgriHelper.Application.Contracts.Identity;
using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Application.DTO.UserDTO.Validator;
using AgriHelper.Application.Exceptions;
using AgriHelper.Application.Features.User.Request.Commands;
using AgriHelper.Application.Features.User.Request.Queries;
using AgriHelper.Application.Model;
using AgriHelper.Application.Responses;
using AutoMapper;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Application.Features.User.Handlers
{
    public class LoginUserQueryHandler : IRequestHandler<LoginUserQuery, BaseCommandResponse<AuthResponse>>
    {
        private readonly IMapper _mapper;
        private readonly IUnitOfWork _unitOfWork;
        private readonly IAuthService _authService;

        public LoginUserQueryHandler(IMapper mapper, IUnitOfWork unitOfWork, IAuthService authService)
        {
            _mapper = mapper;
            _unitOfWork = unitOfWork;
            _authService = authService;
        }
        public async Task<BaseCommandResponse<AuthResponse>> Handle(LoginUserQuery request, CancellationToken cancellationToken)
        {
            var validator = new LoginValidator();
            var validationResult = await validator.ValidateAsync(request.LoginUser);

            if (!validationResult.IsValid) throw new ValidationException(validationResult);


            String token = await _authService.Login(request.LoginUser.Email, request.LoginUser.Password);

            var user = await _unitOfWork.UserRepository.GetUserByEmail(request.LoginUser.Email);    
            var authResponse = new AuthResponse() { UserId = user.UserId, Phone = user.Phone, Email = user.Email, Token = token, Name = user.Name };
            return BaseCommandResponse<AuthResponse>.SuccessHandler(authResponse);
        }
    }
}
