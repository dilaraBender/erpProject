using Backend.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class UpdatePasswordController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UpdatePasswordController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("ChangePassword")]
        public IActionResult ChangePassword(int userId, string newPassword)
        {
            try
            {
                // FromSqlRaw ile sql proseduru çağrılıyor
                _context.Database.ExecuteSqlRaw(
                    "EXEC sp_UpdatePassword @UserId={0}, @NewPassword={1}",
                    userId,
                    newPassword
                );

                // Başarı mesajı döndür 
                return Ok("Şifre güncellendi");
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest(ex.Message);
            }
        }
    }
}