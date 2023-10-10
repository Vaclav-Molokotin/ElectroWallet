using System.ComponentModel.DataAnnotations;

namespace ElectroWallet.Models
{
    public class TransactionType
    {
        public int Id { get; set; }
        [Required]
        public string Name { get; set; }
    }
}
