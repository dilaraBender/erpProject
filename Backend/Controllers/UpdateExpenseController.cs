using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class UpdateExpenseController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UpdateExpenseController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("UpdateExpense")] 
        public IActionResult UpdateExpense(UpdateExpenseDto dto)
        {
            try
            {
                // FromSqlRaw ile sql proseduru çağrılıyor
                _context.Database.ExecuteSqlRaw(
                    "EXEC sp_UpdateExpense @ExpenseId={0},@UserId={1}, @PaymentId={2}, @Title={3}, " +
                    "@Price={4}, @Description={5}, @ExpenseDate={6}",
                    dto.ExpenseId,
                    dto.UserId,
                    dto.PaymentId,
                    dto.Title,
                    dto.Price,
                    dto.Description,
                    dto.ExpenseDate
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
