using Microsoft.EntityFrameworkCore;

namespace Backend.DTOs
{
    [Keyless]
    public class VideoDetailsResponseDto
    {
        public int BayiId { get; set; }
        public int UserId { get; set; }
        public int VideoId { get; set; }
        public string? Title { get;set; } 
        public int WatchedDuration { get; set; }
        public int? TotalDuration { get; set; }
        public decimal CompletionRate { get; set; }
        public bool IsCompleted { get; set; }

    }
}
