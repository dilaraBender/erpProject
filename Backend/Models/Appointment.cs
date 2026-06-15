namespace Backend.Models
{
    public class Appointment
    {
        public int AppointmentId { get; set; }
        public int BayiId { get; set; }
        public Bayi Bayi { get; set; } = null!;
        public int BuildingId { get; set; }
        public Building Buildings { get; set; }= null!;
        public DateTime AppDate { get; set; }
        public TimeSpan? AppTime { get; set; }
        public decimal Price { get; set; }
        public string? Description { get; set; }
        public DateTime CreatedAt { get; set; }
        public string Status { get; set; } = "pending";
    }
}
