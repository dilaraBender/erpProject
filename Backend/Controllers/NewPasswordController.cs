using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class NewPasswordController : ControllerBase
    {
        private readonly AppDbContext _context;

        public NewPasswordController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("NewPassword")]
        public IActionResult ChangePassword(NewPasswordDto dto)
        {
            try
            {
                var user = _context.Users.FirstOrDefault(x => x.UserId == dto.UserId);

                if (user == null)
                    return NotFound("User bulunamadı");

                user.Password = dto.NewPassword;
                user.PasswordChanged = true;

                _context.SaveChanges();

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
