using AgriHelper.Core.Models;

namespace AgriHelper.Application.Contracts.Persistance
{
    public interface IUserRepository: IGenericRepository<User>
    {
        public Task<User> GetUserByEmail(string email);
    }
}
