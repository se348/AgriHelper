using AgriHelper.Application.Contracts.Persistance;
using Microsoft.EntityFrameworkCore.Storage;

namespace AgriHelper.Infrastructure.Repositories
{
    public class UnitOfWork : IUnitOfWork
    {
        private IDbContextTransaction _transaction;

        private IUserRepository _userRepository;

        private IFarmRepository _farmRepository;

        private IFarmUserRepository _farmUserRepository;

        private IFieldRepository _fieldRepository;

        private ISensorRepository _sensorRepository;

        private ISensorResetDateRepository _sensorResetDateRepository;

        private INotificationRepository _notificationRepository;

        private ISensorDateInformationRepository _sensorDateInformationRepository;
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

        public ISensorDateInformationRepository SensorDateInformationRepository => _sensorDateInformationRepository ??= new SensorDateInformationRepository(_dbContext);
        public INotificationRepository NotificationRepository => _notificationRepository ??= new NotificationRepository(_dbContext);

       
        public async Task<int> Save()
        {
            return await _dbContext.SaveChangesAsync();
        }

        public async Task BeginTransaction()
        {
            _transaction = await _dbContext.Database.BeginTransactionAsync();
        }

        public async Task Commit()
        {
            await _transaction?.CommitAsync();
        }

        public async Task RollBack()
        {
            await _transaction?.RollbackAsync();
        }

        public async Task Dispose()
        {
            if (_transaction != null)
            {
                await _transaction.DisposeAsync();
            }
            await _dbContext.DisposeAsync();
            GC.SuppressFinalize(this);

        }

    }
}
