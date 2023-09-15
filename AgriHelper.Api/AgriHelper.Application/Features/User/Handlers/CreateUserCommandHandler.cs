using AgriHelper.Application.Contracts.Identity;
using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Application.DTO.UserDTO.Validator;
using AgriHelper.Application.Exceptions;
using AgriHelper.Application.Features.User.Request.Commands;
using AgriHelper.Application.Model;
using AgriHelper.Application.Responses;
using AutoMapper;
using MediatR;

namespace AgriHelper.Application.Features.User.Handlers
{
    public class CreateUserCommandHandler : IRequestHandler<CreateUserCommand, BaseCommandResponse<AuthResponse>>
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IAuthService _authService;

        public CreateUserCommandHandler(IUnitOfWork unitOfWork, IMapper mapper, IAuthService authService)
        {
            _mapper = mapper;
            _unitOfWork = unitOfWork;
            _authService = authService;
        }
        public async Task<BaseCommandResponse<AuthResponse>> Handle(CreateUserCommand request, CancellationToken cancellationToken)
        {
            await _unitOfWork.BeginTransaction();
            try
            {
                var validator = new CreateUserDTOValidator(_unitOfWork.UserRepository);
                var validationResult = await validator.ValidateAsync(request.CreateUserDTO);

                if (!validationResult.IsValid) throw new ValidationException(validationResult);

                var user = _mapper.Map<AgriHelper.Core.Models.User>(request.CreateUserDTO);

                await _unitOfWork.UserRepository.Add(user);

                await _unitOfWork.Save();

                String token = await _authService.Register(request.CreateUserDTO, _unitOfWork.UserRepository);

                var authResponse = new AuthResponse() { UserId = user.UserId, Phone = user.Phone, Email = user.Email, Token = token , Name= user.Name};
                await _unitOfWork.Commit();
                return BaseCommandResponse<AuthResponse>.SuccessHandler(authResponse);
             

            }
            catch (Exception ex)
            {
                await _unitOfWork.RollBack();
                return BaseCommandResponse<AuthResponse>.FailureHandler(ex);
            }
           
        }
    }
}
