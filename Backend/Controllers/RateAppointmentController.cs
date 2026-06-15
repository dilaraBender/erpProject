using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class RateAppointmentController : ControllerBase
    {
        private readonly AppDbContext _context;

        public RateAppointmentController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("RateAppointment")]
        public async Task<IActionResult> RateAppointment(
            [FromBody] RateAppointmentDto dto
        )
        {
            try
            {
                // FromSqlRaw ile sql proseduru çağrılıyor
                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC sp_RateAppointment @AppointmentId, @Rating",
                    new SqlParameter("@AppointmentId", dto.AppointmentId),
                    new SqlParameter("@Rating", dto.Rating)
                );

                // Başarı mesajı döndür 
                return Ok(new
                {
                    message = "Randevu puanlandı."
                });
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest(new
                {
                    error = ex.Message
                });
            }
        }
    }
}