namespace Backend.DTOs
{
    public class AppointmentListRequestDto
    {
        public int? CustomerId { get; set; }
        public int? BayiId { get; set; }
        public string? Status { get; set; }
        public string? DateType { get; set; }

        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }

    }
}
