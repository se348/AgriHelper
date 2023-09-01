using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Core.Models;
namespace AgriHelper.Infrastructure.Repositories
{
    public class NotificationRepository : GenericRepository<Notification>, INotificationRepository
    {
        private readonly AgriHelperDbContext _context;

        public NotificationRepository(AgriHelperDbContext context) : base(context)
        {
            _context = context;
        }
    }
}
