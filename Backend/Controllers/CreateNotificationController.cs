using Backend.Data;
using Backend.DTOs;
using Backend.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class CreateNotificationController : ControllerBase
    {
        private readonly AppDbContext _context;
        private readonly NotificationService _notificationService;

        public CreateNotificationController(AppDbContext context,
            NotificationService notificationService)
        {
            _context = context;
            _notificationService = notificationService;
        }

        [HttpPost("CreateNotification")]
        public async Task<IActionResult> CreateNotification(CreateNotificationDto dto)
        {
            try
            {
                // FromSqlRaw ile sql proseduru çağrılıyor
                _context.Database.ExecuteSqlRaw(
                    "EXEC sp_CreateNotification @UserId={0}, @Title={1}, @Body={2}",
                    dto.UserId,
                    dto.Title,
                    dto.Body
                );
                var token = await _context.UserTokens
           .Where(x => x.UserId == dto.UserId)
           .Select(x => x.Token)
           .FirstOrDefaultAsync();
                Console.WriteLine("DB TOKEN: " + token);
                if (token != null)
                {
                    await _notificationService.SendPushAsync(
                        token,
                        dto.Title,
                        dto.Body
                    );
                } 

                // Başarı mesajı döndür
                return Ok("Bildirim başarıyla eklendi!");
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"Bildirim eklenirken hata oluştu: {ex.Message}");
            }
        }
    }
}
