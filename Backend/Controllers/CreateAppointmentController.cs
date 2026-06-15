using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class CreateAppointmentController : ControllerBase
    {
        private readonly AppDbContext _context;

        public CreateAppointmentController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("CreateAppointment")]
        public IActionResult CreateAppointment([FromBody] CreateAppointmentDto dto)
        {
            try
            {
                // FromSqlRaw ile sql proseduru çağrılıyor
                _context.Database.ExecuteSqlRaw(
                    "EXEC sp_CreateAppointment @BayiId={0}, @BuildingId={1}, @AppDate={2}, @AppTime={3}," +
                    "@Price={4},@Description={5},@Status={6}",
                    dto.BayiId,
                    dto.BuildingId,
                    dto.AppDate,
                    dto.AppTime,
                    dto.Price,
                    dto.Description,
                    dto.Status
                );

                // Başarı mesajı döndür
                return Ok("Randevu başarıyla eklendi!");
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"Randevu eklenirken hata oluştu: {ex.Message}");
            }
        }
    }
}
