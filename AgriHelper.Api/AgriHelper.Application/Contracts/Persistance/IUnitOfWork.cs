namespace AgriHelper.Application.Contracts.Persistance
{
    public interface IUnitOfWork
    {

        public IUserRepository UserRepository { get; }
        public IFarmRepository FarmRepository { get; }
        public IFarmUserRepository FarmUserRepository{ get; }
        public IFieldRepository FieldRepository { get; }
        public ISensorRepository SensorRepository{ get; }

        public ISensorResetDateRepository SensorResetDateRepository { get; }
        public ISensorDateInformationRepository SensorDateInformationRepository { get; }
        INotificationRepository NotificationRepository { get; }
        Task<int> Save();
        Task BeginTransaction();
        Task Commit();
        Task RollBack();

    }
}
