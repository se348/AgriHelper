using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Application.DTO.UserDTO;
using AgriHelper.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Application.Contracts.Identity
{
    public interface IAuthService
    {
        Task<String?> Register(CreateUserDTO createUserDTO, IUserRepository userRepository);
        Task<String?> Login(string email, string password);
    }
}
