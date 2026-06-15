using System.ComponentModel.DataAnnotations;
namespace Backend.Models
{
    public class VideoProgres
    {
        [Key]
        public int ProgressId { get; set; }
        public int BayiId { get; set; }
        public Bayi Bayi { get; set; } = null!;
        public int VideoId { get; set; }
        public Video Videos { get; set; } = null!;
        public int? WatchedDuration { get; set; }
        public int? LastWatched {  get; set; }
        public decimal? CompletionRate { get; set; }
        public bool IsCompleted { get; set; }
        public string Status { get; set; } = "active";
    }
}
