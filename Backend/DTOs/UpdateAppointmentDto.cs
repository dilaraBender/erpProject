namespace Backend.DTOs
{
    public class UpdateAppointmentDto
    {
        public int AppointmentId { get; set; }
        public string Status { get; set; } = string.Empty;

    }
}
