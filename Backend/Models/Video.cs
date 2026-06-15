namespace Backend.Models
{
    public class Video
    {
        public int VideoId { get; set; }
        public string Title { get; set; } = string.Empty;
        public string? Description { get; set; }
        public int Duration { get; set; }
        public string Url { get; set; } = string.Empty;
        public string? VideoType { get; set; }
        public DateTime CreatedAt { get; set; }
        public string Status { get; set; } = "active";

    }
}
