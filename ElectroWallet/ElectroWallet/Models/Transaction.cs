using System.ComponentModel.DataAnnotations;

namespace ElectroWallet.Models
{
    public class Transaction
    {
        public int Id { get; set; }
        [Required]
        public Guid WalletID { get; set; }
        [Required]
        public string BillTo { get; set; }
        [Required]
        public int TransactionTypeID { get; set; }
        [Required]
        public float Amount { get; set; }
        [Required]
        public int StatusID { get; set; }

        public TransactionType TransactionType { get; set; }
        public Wallet Wallet { get; set; }
        public Status Status { get; set; }
    }
}
