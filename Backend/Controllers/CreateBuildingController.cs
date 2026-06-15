using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class CreateBuildingController : ControllerBase
    {
        private readonly AppDbContext _context;

        public CreateBuildingController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("CreateBuilding")] 
        public IActionResult CreateBuilding(CreateBuildingDto dto)
        {
            try
            {
                // FromSqlRaw ile sql proseduru çağrılıyor
                _context.Database.ExecuteSqlRaw(
                    "EXEC sp_CreateBuilding @CustomerId={0}, @Title={1}, @Address={2}," +
                    "@City={3}, @Latitude={4}, @Longitude={5}",
                    dto.CustomerId,
                    dto.Title,
                    dto.Address,
                    dto.City,
                    dto.Latitude,
                    dto.Longitude
                );

                // Başarı mesajı döndür
                return Ok("Bina başarıyla eklendi!");
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"Bina eklenirken hata oluştu: {ex.Message}");
            }
        }
    }
}
