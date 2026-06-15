using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class DeleteUserController : ControllerBase
    {
        private readonly AppDbContext _context;

        public DeleteUserController(AppDbContext context)
        {
            _context = context;
        }
        [HttpPost("DeleteUser")] 
        public IActionResult DeleteUser(DeleteUserDto dto)
        {
            try
            {
                // FromSqlRaw ile sql proseduru çağrılıyor
                _context.Database.ExecuteSqlRaw(
                    "EXEC sp_DeleteUser @UserId={0}",
                    dto.UserId
                );

                // Başarı mesajı döndür
                return Ok("Kayıt başarıyla silindi!");
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"Kayıt silinemedi: {ex.Message}");
            }
        }
    }
}
