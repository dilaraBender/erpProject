namespace Backend.DTOs
{
    public class CreateVideoDto
    {
        public int VideoId { get; set; }
        public string Title { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public int Duration { get; set; } 
        public string Url { get; set; } = string.Empty;
        public string VideoType { get; set; } = string.Empty;
        public DateTime CreatedAt { get; set; }
    }
}
