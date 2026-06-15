using Microsoft.EntityFrameworkCore;

namespace Backend.DTOs
{
    [Keyless]
    public class DropDownBayiDto
    {
        public int BayiId { get; set; }
        public string Title { get; set; } = string.Empty;
    }
}
