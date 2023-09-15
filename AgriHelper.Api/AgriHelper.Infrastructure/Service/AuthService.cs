using AgriHelper.Application.Contracts.Identity;
using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Application.DTO.UserDTO;
using AgriHelper.Application.Exceptions;
using AgriHelper.Application.Model;
using AgriHelper.Infrastructure.Model;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Infrastructure.Service
{
    public class AuthService : IAuthService
    {
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly SignInManager<ApplicationUser> _signInManager;
        private readonly JwtSetting _jwtSettings;

        public AuthService(UserManager<ApplicationUser> userManager, SignInManager<ApplicationUser> signInManager, IOptions<JwtSetting> jwtSettings)
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _jwtSettings = jwtSettings.Value;
        }

        public async Task<string?> Login(string email, string password)
        {
            var user = await _userManager.FindByEmailAsync(email);
            if (user is null)
            {
                throw new NotFoundException("User not found");
            }
            var result = await _userManager.CheckPasswordAsync(user, password);
            if (result == false)
            {
                throw new NotFoundException("Password not Correct");
            }
            JwtSecurityToken token = await GenerateToken(user, user.Id.ToString());
            var Token = new JwtSecurityTokenHandler().WriteToken(token);
            return Token;
        }

        public async Task<String?> Register(CreateUserDTO createUserDTO, IUserRepository userRepository)
        {
            var alreadyExist = await _userManager.FindByEmailAsync(createUserDTO.Email);
            if (alreadyExist is not null)
            {
                throw new BadRequestException("Email already used");

            }
            var user = new ApplicationUser
            {
                Email = createUserDTO.Email,
                UserName = createUserDTO.Phone,
                EmailConfirmed = true
            };
            var creatingUser = await _userManager.CreateAsync(user, createUserDTO.Password);
            if (!creatingUser.Succeeded)
            {
                throw new BadRequestException($"Check Your Password \n");
            }
            JwtSecurityToken token = await GenerateToken(user, user.Id.ToString());
            var Token = new JwtSecurityTokenHandler().WriteToken(token);
            return Token;
        }

        private async Task<JwtSecurityToken> GenerateToken(ApplicationUser user, string Id)
        {
            var claims = new[]{
             new Claim(JwtRegisteredClaimNames.Sub, user.Email),
             new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
             new Claim(JwtRegisteredClaimNames.Email, user.Email),
             new Claim("reader", Id)

         };
            var ssk = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_jwtSettings.Key));
            var credentialsHashs = new SigningCredentials(ssk, SecurityAlgorithms.HmacSha256);

            var jwtToken = new JwtSecurityToken(
                issuer: _jwtSettings.Issuer,
                audience: _jwtSettings.Audience,
                claims: claims,
                expires: DateTime.Now.AddMinutes(_jwtSettings.DurationInMinutes),
                signingCredentials: credentialsHashs
            );
            return jwtToken;
        }
    }
}
