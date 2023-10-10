using Microsoft.EntityFrameworkCore;

namespace ElectroWallet.Models
{
    public class Currency
    {
        public string Code { get; set; }
        public string Name { get; set; }
        public bool IsCrypto {  get; set; }
        
    }
}