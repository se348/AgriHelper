using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Core.Models;

namespace AgriHelper.Infrastructure.Repositories
{
    public class SensorResetDateRepository : GenericRepository<SensorResetDate>, ISensorResetDateRepository
    {
        private readonly AgriHelperDbContext _context;

        public SensorResetDateRepository(AgriHelperDbContext context) : base(context)
        {
            _context = context;
        }
    }
}
