using Invoice.Data.Entities;

namespace Invoice.DAL.Contracts;

public interface ICategoryRepository
{
    Task<int> AddAsync(CategoryEntity entity);
    Task<IEnumerable<CategoryEntity>> GetAllAsync();
    Task<CategoryEntity?> GetByIdAsync(int id);
    Task<bool> UpdateAsync(CategoryEntity entity);
    Task<bool> DeleteAsync(int id);
}
