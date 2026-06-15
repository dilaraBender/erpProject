using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] //Bu sınıf bir api controller sınıfıdır 
    [Route("api/[controller]")]
    public class UpdateCustomerController : ControllerBase 
    {
        private readonly AppDbContext _context;

        public UpdateCustomerController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("UpdateCustomer")] 
        public IActionResult UpdateCustomer(UpdateCustomerDto dto)
        {
            try
            {
                // FromSqlRaw ile sql proseduru çağrılıyor
                _context.Database.ExecuteSqlRaw(
                    "EXEC sp_UpdateCustomer @UserId={0},@Name={1}, @LastName={2},@Latitude={3},@Longitude={4}, @Phone={5}",
                    dto.UserId,
                    dto.Name,
                    dto.LastName,     
                    dto.Latitude,
                    dto.Longitude,
                    dto.Phone
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
