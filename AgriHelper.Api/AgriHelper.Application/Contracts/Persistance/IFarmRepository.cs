using AgriHelper.Core.Models;

namespace AgriHelper.Application.Contracts.Persistance
{
    public interface IFarmRepository: IGenericRepository<Farm>
    {
        public Task<List<Farm>> GetFarmWithUserId(int userID);
    }
}
