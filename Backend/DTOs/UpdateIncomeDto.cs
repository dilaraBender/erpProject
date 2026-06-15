namespace Backend.DTOs
{
    public class UpdateIncomeDto
    {
        public int IncomeId { get; set; }
        public int UserId { get; set; }
        public int AppointmentId { get; set; }
        public int PaymentId { get; set; }
        public decimal Price { get; set; }
        public string Description { get; set; }
        public DateTime IncomeDate { get; set; }
    }
}
