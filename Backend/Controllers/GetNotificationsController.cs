using Backend.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class GetNotificationsController :ControllerBase
    {
        private readonly AppDbContext _context;

        public GetNotificationsController(AppDbContext context) 
        {
            _context = context;
             }

        [HttpGet("GetUnread/{userId}")]
        public IActionResult GetUnread(int userId)
        {
            var result = _context.Notifications
                // FromSqlRaw ile sql proseduru çağrılıyor
                .FromSqlRaw("EXEC sp_GetUnreadNotifications @UserId={0}", userId)
                .ToList();

            // Başarı mesajı döndür 
            return Ok(result);
        }

        [HttpGet("GetRead/{userId}")]
        public IActionResult GetRead(int userId)
        {
            var result = _context.Notifications
                // FromSqlRaw ile sql proseduru çağrılıyor
                .FromSqlRaw("EXEC sp_GetReadNotifications @UserId={0}", userId)
                .ToList();

            // Başarı mesajı döndür 
            return Ok(result);
        }
    }
}
