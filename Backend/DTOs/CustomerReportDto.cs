using Microsoft.EntityFrameworkCore;

namespace Backend.DTOs
{
    [Keyless]
    public class CustomerReportDto
    {
        public int CustomerId { get; set; }
        public string? Name { get; set; }
        public string? City { get; set; }
        public int Appointment { get; set; }
        public string? LastActive { get; set; }
        public int Score { get; set; }
    }
}
