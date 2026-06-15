using Microsoft.EntityFrameworkCore;

namespace Backend.DTOs
{
    [Keyless]
    public class DropDownCustomerDto
    {
        public int UserId { get; set; }
        public int CustomerId { get; set; }
        public string FullName { get; set; } = string.Empty;
    }
}
