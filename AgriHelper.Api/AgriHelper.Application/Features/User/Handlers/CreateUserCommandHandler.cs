using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Application.DTO.UserDTO.Validator;
using AgriHelper.Application.Exceptions;
using AgriHelper.Application.Features.User.Request.Commands;
using AgriHelper.Application.Responses;
using AutoMapper;
using MediatR;

namespace AgriHelper.Application.Features.User.Handlers
{
    public class CreateUserCommandHandler : IRequestHandler<CreateUserCommand, BaseCommandResponse<int>>
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;

        public CreateUserCommandHandler(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _mapper = mapper;
            _unitOfWork = unitOfWork;
        }
        public async Task<BaseCommandResponse<int>> Handle(CreateUserCommand request, CancellationToken cancellationToken)
        {
            try
            {
                var validator = new CreateUserDTOValidator(_unitOfWork.UserRepository);
                var validationResult = await validator.ValidateAsync(request.CreateUserDTO);

                if (!validationResult.IsValid) throw new ValidationException(validationResult);

                var user = _mapper.Map<AgriHelper.Core.Models.User>(request.CreateUserDTO);

                await _unitOfWork.UserRepository.Add(user);

                await _unitOfWork.Save();

                return BaseCommandResponse<int>.SuccessHandler(user.UserId);

            }
            catch (Exception ex)
            {
                return BaseCommandResponse<int>.FailureHandler(ex);
            }
           
        }
    }
}
