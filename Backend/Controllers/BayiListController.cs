using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] // Bu sınıf bir API controller'dır
    [Route("api/[controller]")]
    public class BayiListController : ControllerBase
    {
        private readonly AppDbContext _context;
        public BayiListController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("BayiList")]
        public IActionResult BayiList([FromBody] BayiListRequestDto dto)
        {
            try
            {
                var bayis = _context.BayiResponse
                    // FromSqlRaw ile sql proseduru çağrılıyor
                    .FromSqlRaw(
                        "EXEC sp_BayiList @Name={0}, @LastName={1}, @City={2}, @Status={3}",
                        dto.Name ?? (object)DBNull.Value,      
                        dto.LastName ?? (object)DBNull.Value,   
                        dto.City ?? (object)DBNull.Value,       
                        dto.Status ?? (object)DBNull.Value      
                    )
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