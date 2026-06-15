using Backend.Data;
using Backend.DTOs;
using Backend.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class UserTokenController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UserTokenController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("save-token")]
        public async Task<IActionResult> SaveToken([FromBody] SaveTokenDto dto)
        {
            Console.WriteLine($"UserId: {dto.UserId}, Token: {dto.Token}"); 
            var existing = await _context.UserTokens
                .FirstOrDefaultAsync(x => x.UserId == dto.UserId);

            if (existing == null)
            {
                _context.UserTokens.Add(new UserToken
                {
                    UserId = dto.UserId,
                    Token = dto.Token
                });
            }

            else
            {
                existing.Token = dto.Token;
            }

            await _context.SaveChangesAsync();

            return Ok("Token kaydedildi");
        }
    }
}