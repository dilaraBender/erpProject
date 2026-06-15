namespace Backend.DTOs
{
    public class BayiListRequestDto
    {
        public string? Name { get; set; } = string.Empty;
        public string? LastName { get; set; } = string.Empty;
        public string? City { get; set; } = string.Empty;
        public string? Status { get; set; } = string.Empty; // active / passive
    }
}
