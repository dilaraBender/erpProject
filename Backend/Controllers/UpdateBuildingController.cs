using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class UpdateBuildingController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UpdateBuildingController(AppDbContext context)
        {
            _context = context;
        }
        [HttpPost("UpdateBuilding")] 
        public IActionResult UpdateBuilding(UpdateBuildingDto dto)
        {
            try
            {
                // FromSqlRaw ile sql proseduru çağrılıyor
                _context.Database.ExecuteSqlRaw(
                    "EXEC sp_UpdateBuilding @CustomerId={0},@Title={1}, @Address={2}, @City={3}," +
                    "@Latitude={4}, @Longitude={5}",
                  dto.CustomerId,
                  dto.Title,
                  dto.Address,
                  dto.City,
                  dto.Latitude, 
                  dto.Longitude
                );

                // Başarı mesajı döndür
                return Ok("Bilgileriniz başarıyla güncellendi!");
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"Bilgileriniz güncellenirken hata oluştu: {ex.Message}");
            }
        }
    }
}
