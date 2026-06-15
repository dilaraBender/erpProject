using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class LoginController : ControllerBase
    {
        private readonly AppDbContext _context;

        public LoginController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("Login")]
        public IActionResult Login( LoginDto dto)
        {
            try
            {
                var result = _context.LoginResponses
                    // FromSqlRaw ile sql proseduru çağrılıyor
                    .FromSqlRaw("EXEC sp_Login @Mail={0}, @Password={1}", dto.Mail, dto.Password)
                    .AsEnumerable()
                    .FirstOrDefault();

                if (result == null)
                    return Unauthorized("Hatalı giriş");

                // Başarı mesajı döndür 
                return Ok(result);
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest(ex.Message);
            }
        }
    }
}