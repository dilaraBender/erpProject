using Microsoft.EntityFrameworkCore;

namespace Backend.DTOs
{
    [Keyless]
    public class BayiReportDto
    {
        public int BayiId { get; set; }
        public string? BayiName { get; set; }
        public string? City { get; set; }
        public string? Status { get; set; }

        public int CustomerCount { get; set; }
        public int AppointmentCount { get; set; }

    }
}
