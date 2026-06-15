namespace Backend.DTOs
{
    public class CreateExpenseDto
    {
        public int UserId { get; set; }
        public int PaymentId { get; set; }
        public string Title { get; set; } = string.Empty;
        public decimal Price { get; set; }
        public string Description { get; set; }
        public DateTime ExpenseDate { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}
