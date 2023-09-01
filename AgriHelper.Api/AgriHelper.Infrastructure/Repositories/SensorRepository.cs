using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Core.Models;
namespace AgriHelper.Infrastructure.Repositories
{
    public class SensorRepository : GenericRepository<Sensor>, ISensorRepository
    {
        private readonly AgriHelperDbContext _context;

        public SensorRepository(AgriHelperDbContext context) : base(context)
        {
            _context = context;
        }
    }
}
