using Backend.Data;
using Backend.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Backend.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class VideoReportController : ControllerBase
    {
        private readonly AppDbContext _context;

        public VideoReportController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet("VideoReport")]
        public IActionResult GetVideoReport()
        {
            try
            {
                var result = _context.VideoReport
                    .FromSqlRaw("EXEC sp_VideoReport")
                    .ToList();

                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest($"Hata: {ex.Message}");
            }
        }
    }
}