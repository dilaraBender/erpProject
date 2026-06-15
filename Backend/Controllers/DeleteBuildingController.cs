using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class DeleteBuildingController : ControllerBase
    {
        private readonly AppDbContext _context;

        public DeleteBuildingController(AppDbContext context)
        {
            _context = context;
        }
        [HttpPost("DeleteBuilding")] 
        public IActionResult DeleteBuilding(DeleteBuildingDto dto)
        {
            try
            {
                // FromSqlRaw ile sql proseduru çağrılıyor
                _context.Database.ExecuteSqlRaw(
                    "EXEC sp_DeleteBuilding @BuildingId={0}",
                    dto.BuildingId
                );

                // Başarı mesajı döndür
                return Ok("Kaydınız başarıyla silindi!");
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"Kaydınız silinirken hata oluştu: {ex.Message}");
            }
        }
    }
}
