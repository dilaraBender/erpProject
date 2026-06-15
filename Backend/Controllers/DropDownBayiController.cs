using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] // Bu sınıf bir API controller'dır
    [Route("api/[controller]")]
    public class DropDownBayiController : ControllerBase
    {
        private readonly AppDbContext _context;
        public DropDownBayiController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet("DropDownBayi")]
        public IActionResult DropDownBayi()
        {
            try
            {
                var bayis = _context.DropDownBayi
                    // FromSqlRaw ile sql proseduru çağrılıyor
                    .FromSqlRaw("EXEC sp_DropDownBayi")
                    .ToList();

                // Başarı mesajı döndür
                return Ok(bayis);
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"İstek işlenirken hata oluştu: {ex.Message}");
            }
        }
    }
}