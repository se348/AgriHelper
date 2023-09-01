
namespace AgriHelper.Application.Contracts.Persistance
{
    public interface IUnitOfWork : IDisposable
    {
        public IUserRepository UserRepository { get; }
        public IFarmRepository FarmRepository { get; }
        public IFarmUserRepository FarmUserRepository{ get; }
        public IFieldRepository FieldRepository { get; }
        public ISensorRepository SensorRepository{ get; }

        public ISensorResetDateRepository SensorResetDateRepository { get; }
        INotificationRepository NotificationRepository { get; }
        Task<int> Save();

    }
}
