using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] // Bu sınıf bir API controller'dır
    [Route("api/[controller]")]
    public class UserListController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UserListController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("UserList")]
        public IActionResult UserList([FromBody] UserListRequestDto dto)
        {
            try
            {
                var users = _context.UserResponse
                    // FromSqlRaw ile sql proseduru çağrılıyor
                    .FromSqlRaw(
                        "EXEC sp_UserList @Role={0}, @Status={1}",
                        dto.Role,
                        dto.Status
                    )
                    .ToList();

                // Başarı mesajı döndür
                return Ok(users);
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"İstek işlenirken hata oluştu: {ex.Message}");
            }
        }
    }
}