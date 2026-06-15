using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] // Bu sınıf bir API controller'dır
    [Route("api/[controller]")]
    public class BuildingListController : ControllerBase
    {
        private readonly AppDbContext _context;
        public BuildingListController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("BuildingList")]
        public IActionResult BuildingList([FromBody] BuildingListRequestDto dto)
        {
            try
            {
                var result = _context.BuildingListResponse
                    // FromSqlRaw ile sql proseduru çağrılıyor
                    .FromSqlRaw(
                        "EXEC sp_GetBuilding @UserId={0}",
                        dto.UserId 
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
}