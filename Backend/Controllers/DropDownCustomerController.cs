using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController] // Bu sınıf bir API controller'dır
    [Route("api/[controller]")]
    public class DropDownCustomerController : ControllerBase
    {
        private readonly AppDbContext _context;
        public DropDownCustomerController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet("DropDownCustomer")]
        public IActionResult DropDownCustomer()
        {
            try
            {
                var customers = _context.DropDownCustomer
                    // FromSqlRaw ile sql proseduru çağrılıyor
                    .FromSqlRaw("EXEC sp_DropDownCustomer")
                    .ToList();

                // Başarı mesajı döndür
                return Ok(customers);
            }
            catch (Exception ex)
            {
                // Hata mesajı döndür
                return BadRequest($"İstek işlenirken hata oluştu: {ex.Message}");
            }
        }
    }
}