namespace Backend.DTOs
{
    public class CreateBayiDto
    {  
        // User tablosuna ait olan bilgiler
        public string Mail { get; set; } = string.Empty;
        public string Status { get; set; } = "active";
        public string Role { get; set; } = "bayi";
        
        // Bayi tablosuna ait olan bilgiler
        public string Name { get; set; } = string.Empty;
        public string LastName { get; set; } = string.Empty;
        public string Phone { get; set; } = string.Empty;
        public string Title { get; set; } = string.Empty;

    }
}
