using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class UpdateVideoProgressController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UpdateVideoProgressController(AppDbContext context)
        {
            _context = context;
        }
        [HttpPost("UpdateVideoProgress")] 
        public IActionResult UpdateVideoProgress(UpdateVideoProgressDto dto)
        {
            try
            {
                // FromSqlRaw ile sql proseduru çağrılıyor
                _context.Database.ExecuteSqlRaw(
                    "EXEC sp_UpdateVideoProgress @BayiId = {0},@VideoId={1},@WatchedDuration={2},@TotalDuration={3}",
                    dto.BayiId,
                    dto.VideoId,
                    dto.WatchedDuration,
                    dto.TotalDuration
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
