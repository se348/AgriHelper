using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Configuration;
using Microsoft.EntityFrameworkCore;
using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Infrastructure.Repositories;
using AgriHelper.Application.Contracts.Common;
using AgriHelper.Infrastructure.Common;

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



            services.AddScoped<IDateTimeProvider, DateTimeProvider>();
            return services;
        }
    }
}
