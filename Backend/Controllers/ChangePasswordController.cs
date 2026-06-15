using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ChangePasswordController : ControllerBase
    {
        private readonly AppDbContext _context;

        public ChangePasswordController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("ChangePassword")]
        public async Task<IActionResult> ChangePassword(
            ChangePasswordRequestDto dto)
        {
            try
            {
                var currentPassword = dto.CurrentPassword?.Trim();
                var newPassword = dto.NewPassword?.Trim();

                if (string.IsNullOrWhiteSpace(currentPassword) ||
                    string.IsNullOrWhiteSpace(newPassword))
                {
                    return BadRequest(new
                    {
                        result = false,
                        message = "Şifre alanları boş olamaz"
                    });
                }

                // mevcut şifre kontrolü
                var user = await _context.Users.FirstOrDefaultAsync(x =>
                    x.UserId == dto.UserId &&
                    x.Password == currentPassword);

                if (user == null)
                {
                    return BadRequest(new
                    {
                        result = false,
                        message = "Mevcut şifre yanlış"
                    });
                }

                // prosedür çağır
                await _context.Database.ExecuteSqlRawAsync(
                    "EXEC sp_ChangePassword @UserId={0}, @CurrentPassword={1}, @NewPassword={2}",
                    dto.UserId,
                    currentPassword,
                    newPassword
                );

                return Ok(new
                {
                    result = true,
                    message = "Şifre başarıyla değiştirildi"
                });
            }
            catch (Exception ex)
            {
                return BadRequest(new
                {
                    result = false,
                    message = "Şifre değiştirilirken hata oluştu",
                    error = ex.Message
                });
            }
        }
    }
}