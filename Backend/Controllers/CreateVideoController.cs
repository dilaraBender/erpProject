using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class CreateVideoController : ControllerBase
    {
        private readonly AppDbContext _context;

        public CreateVideoController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("CreateVideo")] 
        public IActionResult CreateVideo(CreateVideoDto dto)
        {
            try
            {
                // FromSqlRaw ile sql proseduru çağrılıyor
                _context.Database.ExecuteSqlRaw(
                    "EXEC sp_CreateVideo @Title={0}, @Description={1}," +
                    "@Duration={2}, @Url={3},@VideoType={4},@CreatedAt={5}",
                    dto.Title,
                    dto.Description,
                    dto.Duration,
                    dto.Url,
                    dto.VideoType,
                    dto.CreatedAt
                );

                // Başarı mesajı döndür
                return Ok("Video başarıyla eklendi!");
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"Video eklenirken hata oluştu: {ex.Message}");
            }
        }
    }
}
