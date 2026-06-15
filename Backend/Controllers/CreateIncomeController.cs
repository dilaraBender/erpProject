using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class CreateIncomeController : ControllerBase
    {
        private readonly AppDbContext _context;

        public CreateIncomeController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("CreateIncome")]
        public IActionResult CreateIncome(CreateIncomeDto dto)
        {
            try
            {
                // FromSqlRaw ile sql proseduru çağrılıyor
                _context.Database.ExecuteSqlRaw(
                    "EXEC sp_CreateIncome @UserId={0}, @AppointmentId={1}, @PaymentId={2}, @Price={3}," +
                    "@Description={4},@IncomeDate={5},@CreatedAt={6}",
                    dto.UserId,
                    dto.AppointmentId,
                    dto.PaymentId,
                    dto.Price,
                    dto.Description,
                    dto.IncomeDate,
                    dto.CreatedAt
                );

                // Başarı mesajı döndür
                return Ok("Gelir kaydı eklendi!");
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"Gelir kaydı yapılırken hata oluştu: {ex.Message}");
            }
        }
    }
}
