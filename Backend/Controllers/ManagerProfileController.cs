using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] // Bu sınıf bir API controller'dır
    [Route("api/[controller]")]
    public class ManagerProfileController : ControllerBase
    {
        private readonly AppDbContext _context;

        public ManagerProfileController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet("ManagerProfile/{userId}")]
        public IActionResult ManagerProfile(int userId)
        {
            try
            {
                var manager = _context.ManagerProfile
                    // FromSqlRaw ile sql proseduru çağrılıyor
                    .FromSqlRaw("EXEC sp_ManagerProfile @UserId={0}", userId)
                    .AsEnumerable()
                    // kayıt yoksa null varsa ilk kullanıcıyı döndürmek için
                    .FirstOrDefault(); 

                // Eğer kayıt bulunamazsa
                if (manager == null)
                {
                    return Unauthorized("Yönetici bulunamadı!");
                }

                // Başarı mesajı döndür
                return Ok(manager);
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"İstek işlenirken hata oluştu: {ex.Message}");
            }
        }
    }
}