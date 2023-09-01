
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace AgriHelper.Core.Common
{
    public class BaseEntity
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        public string Content { get; set; } = null!;

        public int UserId { get; set; } = 1;

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    }
}
