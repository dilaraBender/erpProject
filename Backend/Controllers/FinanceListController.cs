using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] // Bu sınıf bir API controller'dır
    [Route("api/[controller]")]
    public class FinanceListController : ControllerBase
    {
        private readonly AppDbContext _context;
        public FinanceListController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("FinanceList")]
        public IActionResult FinanceList([FromBody] FinanceListDto dto)
        {
            try
            {
                var result = _context.FinanceListRequest
                    // FromSqlRaw ile sql proseduru çağrılıyor
                    .FromSqlRaw(
                        "EXEC sp_GetFinanceList @UserId={0}, @FinanceType={1}, @DateFilter={2}",
                        // null kontrolleri ile
                        dto.userId,                                 
                        dto.financeType ?? (object)DBNull.Value,   
                        dto.dateFilter ?? (object)DBNull.Value     
                    )
                    .ToList();

                // Başarı mesajı döndür
                return Ok(result);
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"İstek işlenirken hata oluştu: {ex.Message}");
            }
        }
    }
}