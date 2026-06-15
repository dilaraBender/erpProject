using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır  
    [Route("api/[controller]")]
    public class YesterdayAppointmentController : ControllerBase
    {
        private readonly AppDbContext _context;

        public YesterdayAppointmentController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet("YesterdayAppointment")]
        public async Task<IActionResult> GetYesterdayPendingRating()
        {
            try
            {
                var result = await _context.YesterdayAppointment
                    // FromSqlRaw ile sql proseduru çağrılıyor 
                    .FromSqlRaw("EXEC sp_GetYesterdayUnratedAppointment")
                    .AsNoTracking()
                    .ToListAsync();

                var data = result.FirstOrDefault();

                if (data == null)
                    return Ok(null);

                // Başarı mesajı döndür 
                return Ok(data);
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"Hata: {ex.Message}");
            }
        }
    }
}