using AutoMapper;
using Invoice.Data.Entities;
using Invoice.DTOs;

namespace Invoice.BAL.Mapper;

public class Categoryprofile : Profile
{
    public Categoryprofile()
    {
        CreateMap<CategoryEntity, CategoryDto>().ReverseMap();
    }
}
