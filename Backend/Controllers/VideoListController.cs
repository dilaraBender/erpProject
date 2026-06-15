using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] // Bu sınıf bir API controller'dır
    [Route("api/[controller]")]
    public class VideoListController : ControllerBase
    {
        private readonly AppDbContext _context;

        public VideoListController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet("VideoList")]
        public IActionResult VideoList()
        {
            try
            {
                var videos = _context.VideoList
                    // FromSqlRaw ile sql proseduru çağrılıyor
                    .FromSqlRaw("EXEC sp_VideoList")
                    .ToList();

                // Başarı mesajı döndür
                return Ok(videos);
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"İstek işlenirken hata oluştu: {ex.Message}");
            }
        }
    }
}