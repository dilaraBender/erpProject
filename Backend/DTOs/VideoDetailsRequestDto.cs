using Microsoft.EntityFrameworkCore;

namespace Backend.DTOs
{
    [Keyless]
    public class VideoDetailsRequestDto
    {
        public int VideoId { get; set; }
        public int? BayiId { get; set; }
        public bool? IsCompleted { get; set; }
    }
}
