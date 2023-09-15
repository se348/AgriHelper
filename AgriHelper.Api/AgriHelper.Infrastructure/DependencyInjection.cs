using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Configuration;
using Microsoft.EntityFrameworkCore;
using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Infrastructure.Repositories;
using AgriHelper.Application.Contracts.Common;
using AgriHelper.Infrastructure.Common;
using AgriHelper.Application.Model;
using AgriHelper.Application.Contracts.Identity;
using AgriHelper.Infrastructure.Model;
using AgriHelper.Infrastructure.Service;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;

namespace AgriHelper.Infrastructure
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddInfrastructure(this IServiceCollection services, ConfigurationManager configuration)
        {
            var connectionString = configuration.GetConnectionString("DefaultConnection");

            services.AddDbContext<AgriHelperDbContext>(options => options.UseSqlServer(connectionString, b => b.MigrationsAssembly("AgriHelper.Infrastructure")));
            services.AddScoped<IUnitOfWork, UnitOfWork>();
            services.AddScoped(typeof(IGenericRepository<>), typeof(GenericRepository<>));
            services.AddScoped<IUserRepository, UserRepository>();
            services.AddScoped<IFarmRepository, FarmRepository>();
            services.AddScoped<IFarmUserRepository, FarmUserRepository>();
            services.AddScoped<IFieldRepository, FieldRepository>();
            services.AddScoped<INotificationRepository, NotificationRepository>();
            services.AddScoped<ISensorRepository, SensorRepository>();
            services.AddScoped<ISensorResetDateRepository, SensorResetDateRepository>();
            services.AddScoped<IDbInitializer,DBInitializer>();


            services.AddScoped<IDateTimeProvider, DateTimeProvider>();

            services.Configure<JwtSetting>(configuration.GetSection("JwtSetting"));
            services.AddDbContext<UserIdentityDbContext>(options => options.UseSqlServer(connectionString, b => b.MigrationsAssembly("AgriHelper.Infrastructure")));

            services.AddIdentity<ApplicationUser, IdentityRole>()
                .AddEntityFrameworkStores<UserIdentityDbContext>().AddDefaultTokenProviders();


            // to register the auth service for IAuthService 
            services.AddTransient<IAuthService, AuthService>();

            // to add authentication to services container 
            services.AddAuthentication(
                options =>
                {
                    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
                }
                ).AddJwtBearer(
                        o => {

                            o.TokenValidationParameters = new TokenValidationParameters
                            {

                                ValidateIssuerSigningKey = true,
                                ValidateIssuer = true,
                                ValidateAudience = true,
                                ValidateLifetime = true,
                                ClockSkew = TimeSpan.Zero,
                                ValidIssuer = configuration["JwtSetting:Issuer"],
                                ValidAudience = configuration["JwtSetting:Audience"],
                                IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(configuration["JwtSetting:Key"]))
                            };


                        }
                );

            return services;
        }
    }
}
