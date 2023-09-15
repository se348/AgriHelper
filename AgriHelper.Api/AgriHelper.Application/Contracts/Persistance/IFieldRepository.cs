using AgriHelper.Core.Models;
namespace AgriHelper.Application.Contracts.Persistance
{
    public interface IFieldRepository: IGenericRepository<Field>
    {
        public Task<Field> GetWithRelations(int id);
    }
}
