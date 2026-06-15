using System.ComponentModel.DataAnnotations;

namespace Backend.Models
{
    public class Notification
    {
            [Key]
            public int NotId { get; set; }
            public int UserId { get; set; }
            public User User { get; set; } = null!;
            public string Title { get; set; } = string.Empty;
            public string Body { get; set; } = string.Empty;
            public bool IsRead { get; set; } = false;
            public DateTime CreatedAt { get; set; } = DateTime.Now;
        }
    }

