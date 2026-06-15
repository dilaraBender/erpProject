using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class UpdateStatusAppointmentController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UpdateStatusAppointmentController(AppDbContext context)
        {
            _context = context;
        }
        [HttpPost("UpdateStatusAppointment")] 
        public IActionResult UpdateStatusAppointment(UpdateStatusAppointmentDto dto)
        {
            try
            {
                // FromSqlRaw ile sql proseduru çağrılıyors
                _context.Database.ExecuteSqlRaw(
                    "EXEC sp_UpdateStatusAppointment @AppointmentId = {0}, @Status= {1}",
                    dto.AppointmentId,
                    dto.Status
                );

                // Başarı mesajı döndür
                return Ok("Bilgileriniz başarıyla güncellendi!");
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"Bilgileriniz güncellenirken hata oluştu: {ex.Message}");
            }
        }
    }
}
