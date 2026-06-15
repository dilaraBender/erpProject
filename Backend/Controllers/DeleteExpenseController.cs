using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class DeleteExpenseController : ControllerBase
    {
        private readonly AppDbContext _context;

        public DeleteExpenseController(AppDbContext context)
        {
            _context = context;
        }
        [HttpPost("DeleteExpense")] 
        public IActionResult DeleteExpense(DeleteExpenseDto dto)
        {
            try
            {
                // FromSqlRaw ile sql proseduru çağrılıyor
                _context.Database.ExecuteSqlRaw(
                    "EXEC sp_DeleteExpense @ExpenseId={0}",
                 dto.ExpenseId
                );

                // Başarı mesajı döndür
                return Ok("Kaydınız başarıyla silindi!");
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"Kaydınız silinirken hata oluştu: {ex.Message}");
            }
        }
    }
}
