using Microsoft.AspNetCore.Mvc;

namespace Backend.Models
{
    public class Building
    {
        public int BuildingId { get; set; }
        public int CustomerId { get; set; }
        public Customer Customers { get; set; } = null!;
        public string Title { get; set; } = string.Empty;
        public string Address {  get; set; } = string.Empty;
        public string City { get; set; } = string.Empty;
        public DateTime CreatedAt { get; set; }
        public double? Latitude { get; set; }
        public double? Longitude { get; set; }
    }
}
