using System.ComponentModel.DataAnnotations.Schema;

namespace Backend.Models
{
    [Table("Bayis")]
    public class Bayi
    {
        public int BayiId {  get; set; }    
        public int UserId { get; set; }
        public User User { get; set; } = null!;

        public string Name { get; set; } = string.Empty;
        public string LastName { get; set; } = string.Empty;
        public string Title {  get; set; } = string.Empty;
        public string? Tc {  get; set; }
        public string Tax { get; set; } = string.Empty;
        public string? TaxNo { get; set; }
        public string? Phone { get; set; }
        public string City { get; set; } = string.Empty;
        public string Address { get; set; } = string.Empty;
        public DateTime CreatedAt { get; set; }
        public string Status { get; set; } = "active";

    }
}
