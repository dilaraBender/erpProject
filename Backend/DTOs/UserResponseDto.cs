using Microsoft.EntityFrameworkCore;

namespace Backend.DTOs
{
    [Keyless]
    public class UserResponseDto
    {
        public int UserId { get; set; }
        public string FullName { get; set; } = "";
        public string Mail { get; set; } = "";
        public DateTime RegisterDate { get; set; }
        public DateTime? LastLogin { get; set; } 
        public string Role { get; set; } = "";
        public string Status { get; set; } = "";

        public string? BayiPhone { get; set; }
        public string? BayiTitle { get; set; }
        public string? BayiTaxNo { get; set; }
        public DateTime? BayiCreatedAt { get; set; }
        public string? CustomerPhone { get; set; }
    }
}
