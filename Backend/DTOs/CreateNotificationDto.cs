namespace Backend.DTOs
{
    public class CreateNotificationDto
    {
        public int UserId { get; set; }
        public String Title { get; set; } = string.Empty;
        public String Body { get; set; } = string.Empty;
    }
}
