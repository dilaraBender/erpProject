using System.ComponentModel.DataAnnotations;
namespace Backend.Models
{
    public class PaymentMethod
    {
        [Key]
        public int PaymentId { get; set; }
        public string PaymentMethodType { get; set; } = string.Empty;
        public string Status { get; set; } = "active";

    }
}
