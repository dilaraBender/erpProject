namespace Backend.DTOs
{
    public class SaveTokenDto
    {
        public int UserId { get; set; }
        public string Token { get; set; } = string.Empty;

    }
}
