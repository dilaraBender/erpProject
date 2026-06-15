namespace Backend.Models
{
    public class Income
    {
        public int IncomeId { get; set; }
        public int BayiId { get; set; }
        public Bayi Bayi { get; set; } = null!;
        public int? AppointmentId { get; set; }
        public Appointment? Appointment { get; set; } 
        public int PaymentId { get; set; } 
        public PaymentMethod PaymentMethods { get; set; } = null!;
        public decimal Price { get; set; }
        public string? Description { get; set; }
        public DateTime IncomeDate { get; set; }    
         public DateTime CreatedAt { get; set; }
    }
}
