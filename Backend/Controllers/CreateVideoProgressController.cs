using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class CreateVideoProgressController : ControllerBase
    {
        private readonly AppDbContext _context;

        public CreateVideoProgressController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("CreateVideoProgress")] 
        public IActionResult CreateVideoProgress(VideoProgressDto dto)
        {
            try
            {
                // FromSqlRaw ile sql proseduru çağrılıyor
                _context.Database.ExecuteSqlRaw(
                    "EXEC sp_StartVideoProgress @BayiId={0}, @VideoId={1}",
                    dto.BayiId,
                    dto.VideoId
                );

                // Başarı mesajı döndür
                return Ok("Video kaydı başarıyla eklendi!");
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"Video kaydı eklenirken hata oluştu: {ex.Message}");
            }
        }
    }
}
