using Invoice.DTOs;

namespace Invoice.BAL.Contracts;

public interface ICategoryService
{
    Task<int> AddAsync(CategoryDto dto);
    Task<IEnumerable<CategoryDto>> GetAllAsync();
    Task<CategoryDto?> GetByIdAsync(int id);
    Task<bool> UpdateAsync(CategoryDto dto);
    Task<bool> DeleteAsync(int id);
}
