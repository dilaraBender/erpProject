namespace Backend.Models
{
    public class User
    {
        public int UserId { get; set; }
        public string Mail { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public DateTime RegisterDate { get; set; }
        public DateTime? LastLogin { get; set; }
        public string Role { get; set; } = "customer";
        public string Status { get; set; } = "active";
        public bool IsDeleted {  get; set; } = false; 
        public bool PasswordChanged { get; set; } = false;
    }
}
