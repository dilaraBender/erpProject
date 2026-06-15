namespace Backend.DTOs
{
    public class FinanceListDto
    {
        public int userId { get; set; }
        public string? financeType { get; set; }
        public string? dateFilter { get; set; }
    }
}
