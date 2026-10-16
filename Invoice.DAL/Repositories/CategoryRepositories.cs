using Invoice.DAL.Contracts;
using Invoice.Data.Db;
using Invoice.Data.Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Data;

namespace Invoice.DAL.Repositories;

public class CategoryRepositories : ICategoryRepository
{
    private readonly AppDbContext _dbContext;
    public CategoryRepositories(AppDbContext dbContext)
    {
        _dbContext = dbContext;
    }
    public async Task<int> AddAsync(CategoryEntity category)

    {

        var connection = _dbContext.Database.GetDbConnection();


        if (connection.State != ConnectionState.Open)

        {

            await connection.OpenAsync();

        }


        using var command = connection.CreateCommand();


        command.CommandText = "sp_Category_Insert";

        command.CommandType = CommandType.StoredProcedure;


        command.Parameters.Add(

            new SqlParameter("@Code", category.Code));


        command.Parameters.Add(

            new SqlParameter("@Name", category.Name));


        command.Parameters.Add(

            new SqlParameter(

                "@Description",

                (object?)category.Description ?? DBNull.Value));


        command.Parameters.Add(

            new SqlParameter(

                "@IsActive",

                (object?)category.IsActive ?? DBNull.Value));
        command.Parameters.Add(new SqlParameter("@IsDeleted", (object?)category.IsDeleted ?? DBNull.Value));


        var result = await command.ExecuteScalarAsync();


        if (result == null || result == DBNull.Value)

        {

            throw new InvalidOperationException(

                "Category insert did not return the generated Id.");

        }


        return Convert.ToInt32(result);

    }
    public async Task<bool> UpdateAsync(CategoryEntity entity)
    {
        var affectedRows = await _dbContext.Database.ExecuteSqlRawAsync(
            @"EXEC sp_Category_Update
            @Id,
            @Code,
            @name,
            @Description,
            @IsActive,
            @IsDeleted",
            new SqlParameter("@Id", entity.Id),
            new SqlParameter("@Code", entity.Code),
            new SqlParameter("@name", entity.Name),
            new SqlParameter("Description", (object?)entity.Description ?? DBNull.Value),
            new SqlParameter("@IsActive", (object?)entity.IsActive ?? DBNull.Value),
            new SqlParameter("@IsDeleted", (object?)entity.IsDeleted ?? DBNull.Value)
            );

        return affectedRows > 0;
    }

    public async Task<CategoryEntity?> GetByIdAsync(int id)
    {
        var items = await _dbContext.Categories
            .FromSqlRaw("EXEC sp_Category_GetById @Id",
            new SqlParameter("@Id", id))
            .AsNoTracking()
            .ToListAsync();
        return items.FirstOrDefault();
    }

    public async Task<IEnumerable<CategoryEntity>> GetAllAsync()
    {
        return await _dbContext.Categories
            .FromSqlRaw("EXEC sp_Category_GetAll")
            .ToListAsync();
    }

    public async Task<bool> DeleteAsync(int id)
    {
        var affectedRows = await _dbContext.Database.ExecuteSqlRawAsync(
            "EXEC sp_Category_Delete @Id",
            new SqlParameter("@Id", id));

        return affectedRows > 0;
    }
}
