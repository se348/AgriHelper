using AgriHelper.Application.Contracts.Persistance;

namespace AgriHelper.Infrastructure.Repositories
{
    public class UnitOfWork : IUnitOfWork
    {
        private IUserRepository _userRepository;

        private IFarmRepository _farmRepository;

        private IFarmUserRepository _farmUserRepository;

        private IFieldRepository _fieldRepository;

        private ISensorRepository _sensorRepository;

        private ISensorResetDateRepository _sensorResetDateRepository;

        private INotificationRepository _notificationRepository;
        private readonly AgriHelperDbContext _dbContext;

        public UnitOfWork(AgriHelperDbContext dbContext)
        {
            _dbContext = dbContext;
        }



        public IUserRepository UserRepository => _userRepository ??= new UserRepository(_dbContext);

        public IFarmRepository FarmRepository => _farmRepository ??= new FarmRepository(_dbContext);

        public IFarmUserRepository FarmUserRepository => _farmUserRepository ??= new FarmUserRepository(_dbContext);

        public IFieldRepository FieldRepository => _fieldRepository ??= new FieldRepository(_dbContext);

        public ISensorRepository SensorRepository => _sensorRepository ??= new SensorRepository(_dbContext);

        public ISensorResetDateRepository SensorResetDateRepository => _sensorResetDateRepository ??= new SensorResetDateRepository(_dbContext);

        public INotificationRepository NotificationRepository => _notificationRepository ??= new NotificationRepository(_dbContext);

        public void Dispose()
        {
            _dbContext.Dispose();
            GC.SuppressFinalize(this);
        }

        public async Task<int> Save()
        {
            return await _dbContext.SaveChangesAsync();
        }
    }
}
