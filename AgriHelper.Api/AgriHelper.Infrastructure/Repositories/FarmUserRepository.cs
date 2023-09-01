using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Core.Models;

namespace AgriHelper.Infrastructure.Repositories
{
    public class FarmUserRepository : GenericRepository<FarmUser>, IFarmUserRepository
    {
        private readonly AgriHelperDbContext _context;

        public FarmUserRepository(AgriHelperDbContext context) : base(context)
        {
            _context = context;
        }
    }
}
