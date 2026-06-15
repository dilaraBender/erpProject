namespace Backend.DTOs
{
    public class UpdateStatusAppointmentDto
    {
        public int AppointmentId { get; set; }
        public string Status { get; set; }= string.Empty;
    }
}
