using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır   
    [Route("api/[controller]")]
    public class FinanceReportController : ControllerBase
    {
        private readonly AppDbContext _context;

        public FinanceReportController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet("FinanceReport")]
        public IActionResult GetFinanceReport()
        {
            try
            {
                var result = _context.FinanceReport
                    // FromSqlRaw ile sql proseduru çağrılıyor
                    .FromSqlRaw("EXEC sp_FinanceReport")
                    .ToList();

                // Başarı mesajı döndür 
                return Ok(result);
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"Hata: {ex.Message}");
            }
        }
    }
}