using Microsoft.EntityFrameworkCore;

namespace Backend.DTOs
{
    [Keyless]
    public class VideoReportDto
    {
        public int VideoId { get; set; }
        public string Title { get; set; }

        public int Views { get; set; }

        public decimal AvgCompletion { get; set; } 

        public int CompletedCount { get; set; }
    }
}
