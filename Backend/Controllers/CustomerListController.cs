using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] // Bu sınıf bir API controller'dır
    [Route("api/[controller]")]
    public class CustomerListController : ControllerBase
    {
        private readonly AppDbContext _context;
        public CustomerListController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("CustomerList")]
        public IActionResult CustomerList([FromBody] CustomerListRequestDto dto)
        {
            try
            {
                var customers = _context.CustomerResponse
                    // FromSqlRaw ile sql proseduru çağrılıyor
                    .FromSqlRaw(
                        "EXEC sp_CustomerList @Name={0}, @LastName={1}, @Status={2}",
                        // null kontrolleri sağlanarak
                        dto.Name ?? (object)DBNull.Value,
                        dto.LastName ?? (object)DBNull.Value,
                        dto.Status ?? (object)DBNull.Value
                    )
                    .ToList();

                // Başarı mesajı döndür
                return Ok(customers);
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"İstek işlenirken hata oluştu: {ex.Message}");
            }
        }
    }
}
