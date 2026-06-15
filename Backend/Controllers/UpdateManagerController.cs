using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class UpdateManagerController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UpdateManagerController(AppDbContext context) 
        {
            _context = context;
        }

        [HttpPost("UpdateManager")] 
        public IActionResult UpdateManager(UpdateManagerDto dto)
        {
            try
            {
                // FromSqlRaw ile sql proseduru çağrılıyor
                _context.Database.ExecuteSqlRaw(
                    "EXEC sp_UpdateManager @UserId={0},@Name={1}, @LastName={2}, @Phone={3},@Latitude={4},@Longitude={5}",
                    dto.UserId,
                    dto.Name,
                    dto.LastName,
                    dto.Phone,
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
