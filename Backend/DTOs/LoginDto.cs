using Microsoft.EntityFrameworkCore;

namespace Backend.DTOs
{
    // Kullanıcı giriş bilgilerini almak için
    public class LoginDto
    {
        public string Mail { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
    }

    // Login sonrası dönecek veri
    [Keyless]
    public class LoginResponseDto
    {
        public int UserId { get; set; }
        public string Mail { get; set; } = string.Empty;
        public int? BayiId { get; set; }
        public int? CustomerId { get; set; }
        public int? ManagerId { get; set; }
        public string Role { get; set; } = string.Empty;
        public bool PasswordChanged { get; set; }
        public double? BayiLatitude { get; set; }
        public double? BayiLongitude { get; set; }

        public double? CustomerLatitude { get; set; }
        public double? CustomerLongitude { get; set; }

        public double? ManagerLatitude { get; set; }
        public double? ManagerLongitude { get; set; }
    }
}