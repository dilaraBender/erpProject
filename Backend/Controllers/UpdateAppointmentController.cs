using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class UpdateAppointmentController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UpdateAppointmentController(AppDbContext context)
        {
            _context = context;
        }
        [HttpPost("UpdateAppointment")]
        public IActionResult UpdateAppointment(UpdateAppointmentDto dto)
        {
            try
            {
                // FromSqlRaw ile sql proseduru çağrılıyor
                _context.Database.ExecuteSqlRaw(
                    "EXEC sp_UpdateAppointment @AppointmentId={0}, @Status={1}",
                   dto.AppointmentId,
                   dto.Status
                );

                // Başarı mesajı döndür
                return Ok("Randevu başarıyla güncellendi!");
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"Randevu güncellenirken hata oluştu: {ex.Message}");
            }
        }
    }
}
