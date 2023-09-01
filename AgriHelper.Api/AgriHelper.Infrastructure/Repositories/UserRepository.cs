using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Core.Models;
using Microsoft.EntityFrameworkCore;

namespace AgriHelper.Infrastructure.Repositories
{
    public class UserRepository : GenericRepository<User>, IUserRepository
    {
        private readonly AgriHelperDbContext _context;

        public UserRepository(AgriHelperDbContext context) : base(context)
        {
            _context = context;
        }

        public async Task<User> GetUserByEmail(string email)
        {
           return await _context.Users.Where(a => a.Email == email).FirstOrDefaultAsync();
        }
    }
}
