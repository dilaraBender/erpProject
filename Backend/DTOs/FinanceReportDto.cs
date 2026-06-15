using Microsoft.EntityFrameworkCore;

namespace Backend.DTOs
{
    [Keyless]
    public class FinanceReportDto
    {
        public string Title { get; set; }
        public decimal Amount { get; set; }
        public string Type { get; set; } // income / expense
    }
}
