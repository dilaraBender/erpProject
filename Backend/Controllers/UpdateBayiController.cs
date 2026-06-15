using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class UpdateBayiController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UpdateBayiController(AppDbContext context)
        {
            _context = context;
        }
        [HttpPost("UpdateBayi")] 
        public IActionResult UpdateBayi(UpdateBayiDto dto)
        {
            try
            {
                // FromSqlRaw ile sql proseduru çağrılıyor
                _context.Database.ExecuteSqlRaw(
                    "EXEC sp_UpdateBayi @UserId={0},@Name={1}, @LastName={2}, @Tc={3}, @Tax={4},@TaxNo={5}," +
                    "@Phone={6},@City={7}, @Address={8}, @Title={9}, @Latitude={10}, @Longitude = {11}",
                    dto.UserId,
                    dto.Name,
                    dto.LastName,
                    dto.Tc,
                    dto.Tax,
                    dto.TaxNo,
                    dto.Phone,
                    dto.City,
                    dto.Address,
                    dto.Title,
                    dto.Latitude,
                    dto.Longitude
                );

                // Başarı mesajı döndür
                return Ok("Bilgileriniz başarıyla güncellendi!");
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"Bilgileriniz güncellenirken hata oluştu: {ex.Message}");
            }
        }
    }
}
