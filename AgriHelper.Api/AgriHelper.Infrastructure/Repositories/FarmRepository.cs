using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Core.Models;
using Microsoft.EntityFrameworkCore;

namespace AgriHelper.Infrastructure.Repositories
{
    public class FarmRepository: GenericRepository<Farm>, IFarmRepository
    {
        private readonly AgriHelperDbContext _context;

        public FarmRepository(AgriHelperDbContext context): base(context) 
        {
            _context = context;
        }

        public async Task<Farm> GetFarmWithRelations(int farmId)
        {
            var farm = await _context.Farms.Include(f => f.Fields).ThenInclude(b => b.Notifications).Where(a => a.FarmId == farmId).FirstOrDefaultAsync();
            return farm;
        }

        public async Task<List<Farm>> GetFarmWithUserId(int userID)
        {
            var user = await _context.Users.Include(a => a.FarmUsers).ThenInclude(b => b.Farm)
                                .Where(a => a.UserId == userID)
                                .FirstOrDefaultAsync();
            List<Farm> result = new List<Farm>();

            foreach (var farm in user.FarmUsers)
            {
                result.Add(farm.Farm);
            }

            return result;
        }
    }
}
