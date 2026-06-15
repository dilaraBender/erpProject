using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AppointmentReportController : ControllerBase
    {
        private readonly AppDbContext _context;

        public AppointmentReportController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet("AppointmentReport")]
        public IActionResult AppointmentReport()
        {
            try
            {
                var result = _context.Set<AppointmentReportDto>()
                    
                    // FromSqlRaw ile sql proseduru çağrılıyor
                    .FromSqlRaw("EXEC sp_AppointmentReport")
                    .ToList();

                if (result == null || result.Count == 0)
                    return NotFound("Randevu raporu bulunamadı");

                // Başarı mesajı döndür
                return Ok(result);
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"Hata oluştu: {ex.Message}");
            }
        }
    }
}