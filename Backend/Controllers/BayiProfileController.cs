using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] // Bu sınıf bir API controller'dır
    [Route("api/[controller]")]
    public class BayiProfileController : ControllerBase
    {
        private readonly AppDbContext _context;
        public BayiProfileController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet("BayiProfile/{userId}")]
        public IActionResult BayiProfile(int userId)
        {
            try
            {
                var bayi = _context.BayiProfile
                    // FromSqlRaw ile sql proseduru çağrılıyor
                    .FromSqlRaw("EXEC sp_BayiProfile @UserId={0}", userId)
                    .AsEnumerable()
                    // kayıt yoksa null varsa ilk kullanıcıyı döndürmek için
                    .FirstOrDefault(); 

                // Eğer kayıt bulunamazsa
                if (bayi == null)
                {
                    return Unauthorized("Bayi bulunamadı!");
                }

                // Başarı mesajı döndür
                return Ok(bayi);
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"İstek işlenirken hata oluştu: {ex.Message}");
            }
        }
    }
}