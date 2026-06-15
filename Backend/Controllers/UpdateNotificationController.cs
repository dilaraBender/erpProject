using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class UpdateNotificationController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UpdateNotificationController(AppDbContext context)
        {
            _context = context;
        }
        [HttpPost("UpdateNotification")]
        public IActionResult UpdateNotification(UpdateNotificationDto dto)
        {
            try
            {
                // FromSqlRaw ile sql proseduru çağrılıyor
                _context.Database.ExecuteSqlRaw(
                    "EXEC sp_UpdateNotification @NotId={0}",
                   dto.NotId
                );

                // Başarı mesajı döndür
                return Ok("Bildirim güncellendi!");
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"Bildirim güncellenirken hata oluştu: {ex.Message}");
            }
        }
    }
}
