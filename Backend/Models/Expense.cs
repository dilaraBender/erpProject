namespace Backend.Models
{
    public class Expense
    {
        public int ExpenseId { get; set; }
        public int BayiId { get; set; }
        public Bayi Bayi { get; set; } = null!;
        public int PaymentId { get; set; } 
        public PaymentMethod PaymentMethods { get; set; } = null!;
        public string Title { get; set; } = string.Empty;
        public decimal Price { get; set; }
        public string? Description { get; set; }
        public DateTime ExpenseDate { get; set; }
        public DateTime CreatedAt { get; set; }

    }
}
