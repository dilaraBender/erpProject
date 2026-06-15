using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] // Bu sınıf bir API controller'dır
    [Route("api/[controller]")]
    public class CustomerProfileController : ControllerBase
    {
        private readonly AppDbContext _context;
        public CustomerProfileController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet("CustomerProfile/{userId}")]
        public IActionResult CustomerProfile(int userId)
        {
            try
            {
                var customer = _context.CustomerProfile
                    // FromSqlRaw ile sql proseduru çağrılıyor
                    .FromSqlRaw("EXEC sp_CustomerProfile @UserId={0}", userId)
                    .AsEnumerable()
                    // kayıt yoksa null varsa ilk kullanıcıyı döndürmek için
                    .FirstOrDefault();

                // Eğer kayıt bulunamazsa
                if (customer == null)
                {
                    return Unauthorized("Müşteri bulunamadı!");
                }

                // Başarı mesajı döndür
                return Ok(customer);
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"İstek işlenirken hata oluştu: {ex.Message}");
            }
        }
    }
}