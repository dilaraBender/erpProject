using System.Security.Cryptography;
using System.Text;

namespace Backend.Controllers
{
    public static class PasswordGenetorController
    {
        public static string Generate(int length = 8)
        {
            // karakter havuzundan random şifre oluşturuyoruz
            const string chars = "ABCDEFGHJKLMNOPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz0123456789";

            var data = new byte[length];
            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(data);
            }

            var result = new StringBuilder(length);
            foreach (var b in data)
            {
                result.Append(chars[b % chars.Length]);
            }

            return result.ToString();
        }
    }
}
