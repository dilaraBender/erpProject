namespace Backend.DTOs
{
    public class UpdateVideoProgressDto
    {
        public int BayiId { get; set; }
        public int VideoId { get; set; }
        public int WatchedDuration { get; set; }
        public int TotalDuration { get; set; }
    }
}
