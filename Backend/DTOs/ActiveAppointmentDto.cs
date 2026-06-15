
using Microsoft.EntityFrameworkCore;

[Keyless]
public class ActiveAppointmentDto
{
    public int AppointmentId { get; set; }
    public int BayiId { get; set; }
    public int BuildingId { get; set; }

    public DateTime AppointmentDate { get; set; }
    public DateTime ChatStart { get; set; }
    public DateTime ChatEnd { get; set; }

    public bool CanChat { get; set; }
}