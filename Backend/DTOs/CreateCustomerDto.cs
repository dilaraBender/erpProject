namespace Backend.DTOs
{
    public class CreateCustomerDto
    {
        // User tablosuna ait olan bilgiler
        public string Mail {  get; set; } =string.Empty;  
        public string Status { get; set; } = "active";
        public string Role { get; set; } = "customer";
      
        // Customer tablosuna ait olan bilgiler
        public string Name { get; set; } =string.Empty;
        public string LastName { get; set; } = string.Empty;
        public string Phone { get; set; } = string.Empty;
    }
}
