namespace ElectroWallet.Models
{
    public class Wallet
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public float Amount { get; set; }
        public bool IsFrozen { get; set; }
        public int UserID { get; set; }

        public User? User { get; set; }
        public Currency? CurrencyType {  get; set; }
    }
}
