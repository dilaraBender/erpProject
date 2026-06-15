using Microsoft.EntityFrameworkCore;

namespace Backend.DTOs
{
    [Keyless]
    public class DropDownBuildingDto
    {
        public int BuildingId { get; set; }
        public string Title { get; set; } = string.Empty;

    }
}
