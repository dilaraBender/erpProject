using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[ApiController] // Bu sınıf bir API controller'dır
[Route("api/[controller]")]
public class VideoDetailsController : ControllerBase
{
    private readonly AppDbContext _context;

    public VideoDetailsController(AppDbContext context)
    {
        _context = context;
    }

    [HttpPost("VideoDetails")]
    public IActionResult VideoDetails([FromBody] VideoDetailsRequestDto dto)
    {
        try
        {
            var result = _context.VideoDetailsResponse
                // FromSqlRaw ile sql proseduru çağrılıyor
                .FromSqlRaw(
                    "EXEC sp_GetVideoProgress @VideoId={0}, @BayiId={1}, @IsCompleted={2}",
                    dto.VideoId,
                    dto.BayiId,
                    dto.IsCompleted
                )
                .ToList();

            // Başarı mesajı döndür
            return Ok(result);
        }
        catch (Exception ex)
        {
            // Hata mesajı döndür
            return BadRequest($"İstek işlenirken hata oluştu: {ex.Message}");
        }
    }
}