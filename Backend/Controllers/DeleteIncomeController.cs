using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class DeleteIncomeController : ControllerBase
    {
        private readonly AppDbContext _context;

        public DeleteIncomeController(AppDbContext context)
        {
            _context = context;
        }
        [HttpPost("DeleteIncome")] 
        public IActionResult DeleteIncome(DeleteIncomeDto dto)
        {
            try
            {
                // FromSqlRaw ile sql proseduru çağrılıyor
                _context.Database.ExecuteSqlRaw(
                    "EXEC sp_DeleteIncome @IncomeId={0}",
                    dto.IncomeId
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
