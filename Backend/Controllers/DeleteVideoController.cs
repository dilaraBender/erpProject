using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class DeleteVideoController : ControllerBase
    {
        private readonly AppDbContext _context;

        public DeleteVideoController(AppDbContext context)
        {
            _context = context;
        }
        [HttpPost("DeleteVideo")] 
        public IActionResult DeleteUser(DeleteVideoDto dto)
        {
            try
            {
                // FromSqlRaw ile sql proseduru çağrılıyor
                _context.Database.ExecuteSqlRaw(
                    "EXEC sp_DeleteVideo @VideoId={0}",
                    dto.VideoId
                );

                // Başarı mesajı döndür
                return Ok("Kayıt başarıyla silindi!");
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"Kayıt silinemedi: {ex.Message}");
            }
        }
    }
}
