using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ActiveAppointmentsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public ActiveAppointmentsController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet("ActiveAppointments")]
        public IActionResult GetMyActiveAppointment(int userId)
        {
            try
            {
                var result = _context.ActiveAppointment
                    // FromSqlRaw ile sql proseduru çağrılıyor
                    .FromSqlRaw(
                        "EXEC sp_GetMyActiveAppointment @UserId={0}",
                        userId
                    )
                    .AsEnumerable()
                    .FirstOrDefault();

                if (result == null)
                    return NotFound("Aktif randevu bulunamadı");

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