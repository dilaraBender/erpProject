using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class CreateExpenseController : ControllerBase
    {
        private readonly AppDbContext _context;

        public CreateExpenseController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("CreateExpense")]
        public IActionResult CreateExpense(CreateExpenseDto dto)
        {
            try
            {
                // FromSqlRaw ile sql proseduru çağrılıyor
                _context.Database.ExecuteSqlRaw(
                    "EXEC sp_CreateExpense @UserId={0}, @PaymentId={1}, @Title={2}, @Price={3}," +
                    "@Description={4},@ExpenseDate={5},@CreatedAt={6}",
                    dto.UserId,
                    dto.PaymentId,
                    dto.Title,
                    dto.Price,
                    dto.Description,
                    dto.ExpenseDate,
                    dto.CreatedAt
                );

                // Başarı mesajı döndür
                return Ok("Gider kaydı eklendi!");
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"Gider kaydı yapılırken hata oluştu: {ex.Message}");
            }
        }
    }
}
