using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CreateBayiController : ControllerBase
    {
        private readonly AppDbContext _context;
        private readonly EmailService _emailService;

        public CreateBayiController(AppDbContext context, EmailService emailService)
        {
            _context = context;
            _emailService = emailService;
        }

        [HttpPost("CreateBayi")]
        public async Task<IActionResult> CreateBayi(CreateBayiDto dto)
        {
            try
            {
                // 1. Şifre üret
                var tempPassword = PasswordGenetorController.Generate();

                // 2. DB'ye kaydet
                _context.Database.ExecuteSqlRaw(
                    "EXEC sp_CreateBayi @Mail={0}, @Password={1}, @Status={2}, @Role={3}, " +
                    "@Name={4}, @LastName={5}, @Phone={6}, @Title={7}",
                    dto.Mail,
                    tempPassword,
                    dto.Status,
                    dto.Role,
                    dto.Name,
                    dto.LastName,
                    dto.Phone,
                    dto.Title
                );

                // 3. Mail gönder
                await _emailService.SendEmail(dto.Mail, tempPassword);

                // 4. Response
                return Ok(new
                {
                    message = "Bayi başarıyla oluşturuldu"
                });
            }
            catch (Exception ex)
            {
                return BadRequest(new
                {
                    message = "Bayi oluşturulurken hata oluştu",
                    error = ex.Message
                });
            }
        }
    }
}