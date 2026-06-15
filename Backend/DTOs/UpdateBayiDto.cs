namespace Backend.DTOs
{
    public class UpdateBayiDto
    {
        public int UserId { get; set; }
        public string Name { get; set; } = string.Empty;
        public string LastName { get; set; } = string.Empty;
        public string Tc { get; set; } = string.Empty;
        public string Phone { get; set; } = string.Empty;
        public string Tax { get; set; } = string.Empty;
        public string TaxNo { get; set; } = string.Empty;
        public string City { get; set; } = string.Empty;
        public string Address { get; set; } = string.Empty;
        public string Title { get; set; } = string.Empty;
        public double Latitude { get; set; }
        public double Longitude { get; set; }
    }
}
