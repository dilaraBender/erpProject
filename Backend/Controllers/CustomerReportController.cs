using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır   
    [Route("api/[controller]")]
    public class CustomerReportController : ControllerBase
    {
        private readonly AppDbContext _context;

        public CustomerReportController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet("CustomerReport")]
        public IActionResult CustomerReport()
        {
            try
            {
                var result = _context.CustomerReports
                    // FromSqlRaw ile sql proseduru çağrılıyor
                    .FromSqlRaw("EXEC sp_CustomerReport")
                    .ToList();

                // Başarı mesajı döndür
                return Ok(result);
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest(ex.Message);
            }
        }
    }
}