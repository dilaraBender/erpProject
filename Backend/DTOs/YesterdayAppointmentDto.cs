using Microsoft.EntityFrameworkCore;

namespace Backend.DTOs
{
    [Keyless] 
    public class YesterdayAppointmentDto
    {
        public int AppointmentId { get; set; }

        public DateTime AppDate { get; set; }
        public TimeSpan? AppTime { get; set; }

        public string CustomerName { get; set; }
        public string Phone { get; set; }

        public int BayiId { get; set; }
        public string BayiName { get; set; }

        public int BuildingId { get; set; }
        public string BuildingTitle { get; set; }
        public string Address { get; set; }
        public string City { get; set; }

        public double? Latitude { get; set; }
        public double? Longitude { get; set; } 
    }
}
