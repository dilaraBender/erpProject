using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController]  // Bu sınıf bir API controller'dır
    [Route("api/[controller]")]
    public class BayiReportController : ControllerBase
    {
        private readonly AppDbContext _context;

        public BayiReportController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet("BayiReport")]
        public IActionResult GetReport()
        {
            try
            {
                var result = _context.BayiReports
                    // FromSqlRaw ile sql proseduru çağrılıyor 
                    .FromSqlRaw("EXEC sp_BayiReport")
                    .ToList();

                // Başarı mesajı döndür
                return Ok(result);
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"Rapor alınırken hata oluştu: {ex.Message}");
            }
        }
    }
    }
