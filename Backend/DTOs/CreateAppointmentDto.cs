using Backend.Models;

namespace Backend.DTOs
{
    public class CreateAppointmentDto
    {
        public int BayiId { get; set; }
        public int BuildingId { get; set; }
        public DateTime AppDate { get; set; }
        public DateTime AppTime { get; set; }
        public decimal Price { get; set; }
        public string Description { get; set; } = string.Empty;
        public string Status { get; set; } = "pending";
    }
}
