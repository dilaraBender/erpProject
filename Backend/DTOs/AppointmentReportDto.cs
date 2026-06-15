using Microsoft.EntityFrameworkCore;

namespace Backend.DTOs
{
    [Keyless]
    public class AppointmentReportDto
    {
        public int AppointmentId { get; set; }

        public string? CustomerName { get; set; }
        public string? DealerName { get; set; }

        public string? City { get; set; }

        public DateTime AppDateTime { get; set; }

        public string? Status { get; set; }
        public int? Rating { get; set; }

        public int TotalAppointments { get; set; }
        public int CompletedCount { get; set; }
        public int PendingCount { get; set; }
        public int CancelledCount { get; set; }

        public int DailyCount { get; set; } 
    }
}
