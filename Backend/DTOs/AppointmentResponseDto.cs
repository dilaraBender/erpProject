using Microsoft.EntityFrameworkCore;

namespace Backend.DTOs
{
    [Keyless]
    public class AppointmentResponseDto
    {
        public int AppointmentId { get; set; }

        public DateTime AppDate { get; set; }
        public TimeSpan? AppTime { get; set; }

        public decimal? Price { get; set; }
        public string? Description { get; set; }

        public string? Status { get; set; }
        public int? Rating { get; set; }

        // 🟢 BAYİ
        public int? BayiId { get; set; }
        public string? BayiTitle { get; set; }
        public string? BayiName { get; set; }

        // 🟢 BUILDING (HARİTA İÇİN KRİTİK)
        public int? BuildingId { get; set; }
        public string? BuildingTitle { get; set; }
        public string? Address { get; set; }
        public string? City { get; set; }

        // 🟢 CUSTOMER
        public int? CustomerId { get; set; }
        public string? CustomerName { get; set; }
        public string? Phone { get; set; }

        // 🗺️ HARİTA KOORDİNATLARI (EN ÖNEMLİ EKLENTİ)
        public double? Latitude { get; set; }
        public double? Longitude { get; set; }
    }
}