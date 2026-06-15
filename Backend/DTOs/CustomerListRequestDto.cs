namespace Backend.DTOs
{
    public class CustomerListRequestDto
    {
        public string? Name { get; set; } = string.Empty;
        public string? LastName { get; set; } = string.Empty;
        public string? Status { get; set; } = string.Empty; // active / passive
    }
}
