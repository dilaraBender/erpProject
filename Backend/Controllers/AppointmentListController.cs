using Backend.Data;
using Microsoft.AspNetCore.Mvc;
using Backend.DTOs;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AppointmentListController : ControllerBase
    {
        private readonly AppDbContext _context;

        public AppointmentListController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("AppointmentList")]
        public IActionResult AppointmentList([FromBody] AppointmentListRequestDto dto)
        {
            try
            {
                var result = _context.AppointmentResponse
                    // FromSqlRaw ile sql proseduru çağrılıyor
                    .FromSqlRaw(
                        "EXEC sp_AppointmentList @CustomerId={0}, @BayiId={1}, @Status={2}, @DateType={3}, @StartDate={4}, @EndDate={5}",
            dto.CustomerId,
            dto.BayiId,
            dto.Status,
            dto.DateType,
            dto.StartDate,
            dto.EndDate
        )
        .ToList();

                // Başarı mesajı döndür
                return Ok(result);
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"İstek işlenirken hata oluştu {ex.Message}");
            }
        }
    }
}