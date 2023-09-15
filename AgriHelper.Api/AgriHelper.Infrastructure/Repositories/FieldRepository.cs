using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Core.Models;
using Microsoft.EntityFrameworkCore;

namespace AgriHelper.Infrastructure.Repositories
{
    public class FieldRepository : GenericRepository<Field>, IFieldRepository
    {
        private readonly AgriHelperDbContext _context;

        public FieldRepository(AgriHelperDbContext context) : base(context)
        {
            _context = context;
        }

        public async Task<Field> GetWithRelations(int id)
        {
            var field = await _context.Fields.Where(a => a.FieldId == id).Include(a => a.Notifications).Include(b => b.Sensors).FirstOrDefaultAsync();
            return field;
        }

       
    }
}
