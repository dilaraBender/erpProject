using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] // Bu sınıf bir API controller'dır
    [Route("api/[controller]")]
    public class DropDownBuildingController : ControllerBase
    {
        private readonly AppDbContext _context;
        public DropDownBuildingController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet("DropDownBuilding/{userId}")]
        public IActionResult DropDownBuilding(int userId)
        {
            try
            {
                var buildings = _context.DropDownBuilding
                    // FromSqlRaw ile sql proseduru çağrılıyor
                    .FromSqlRaw(
                        "EXEC sp_DropDownBuilding @UserId={0}",
                        userId).ToList();

                // Başarı mesajı döndür
                return Ok(buildings);
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"İstek işlenirken hata oluştu: {ex.Message}");
            }
        }
    }
}