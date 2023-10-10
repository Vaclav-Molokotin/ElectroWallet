using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;

namespace ElectroWallet.Models
{
    public class User
    {
        
        public int ID { get; set; }
        [Required]
        public string Login {  get; set; }
        [Required]
        public string Password { get; set; }
        [Required]
        public DateTime CreationDate { get; set; }
        
        public string TokenAPI { get; set; }
    }
}
