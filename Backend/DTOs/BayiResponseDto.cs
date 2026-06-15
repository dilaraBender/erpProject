using Microsoft.EntityFrameworkCore;

namespace Backend.DTOs
{
    [Keyless]
    public class BayiResponseDto
    {
        public int BayiId { get; set; }
        public string FullName { get; set; } = string.Empty;
        public string Mail { get; set; } = string.Empty;
        public string Status { get; set; } = string.Empty;
        public string? Phone { get; set; } = string.Empty;
        public string? City { get; set; } = string.Empty;
        public string? Address { get; set; } = string.Empty;
        public string? Tc { get; set; } = string.Empty;
        public string? Tax { get; set; } = string.Empty;
        public string? Title { get; set; } = string.Empty;
        public string? TaxNo { get; set; } = string.Empty;
        public double? Latitude { get; set; }
        public double? Longitude { get; set; }
        public DateTime? CreatedAt { get; set; }
    }
}
