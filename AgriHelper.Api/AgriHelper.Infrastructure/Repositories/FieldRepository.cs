using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Core.Models;

namespace AgriHelper.Infrastructure.Repositories
{
    public class FieldRepository : GenericRepository<Field>, IFieldRepository
    {
        private readonly AgriHelperDbContext _context;

        public FieldRepository(AgriHelperDbContext context) : base(context)
        {
            _context = context;
        }
    }
}
