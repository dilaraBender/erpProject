using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class UpdateIncomeController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UpdateIncomeController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("UpdateIncome")] 
        public IActionResult UpdateIncome(UpdateIncomeDto dto)
        {
            try
            {
                // FromSqlRaw ile sql proseduru çağrılıyor
                _context.Database.ExecuteSqlRaw(
                    "EXEC sp_UpdateIncome @IncomeId={0},@UserId={1}, @AppointmentId={2}, @PaymentId={3}," +
                    "@Price={4}, @Description={5}, @IncomeDate={6}",
                     dto.IncomeId,
                     dto.UserId,
                     dto.AppointmentId,
                     dto.PaymentId,
                     dto.Price,
                     dto.Description,
                     dto.IncomeDate
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
