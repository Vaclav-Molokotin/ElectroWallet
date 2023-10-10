using ElectroWallet.Libs;
using ElectroWallet.Models;
using Microsoft.AspNetCore.Mvc;
using System.Transactions;

namespace ElectroWallet.Controllers
{
    public class TransactionController : Controller
    {
        private ApplicationContext _context;
        public TransactionController(ApplicationContext context)
        {
            _context = context;
        }

        [HttpPost("api/GetTransactions")]
        public IActionResult GetTransactions(string token, DateTime dateFrom, DateTime dateTo, Guid walletGuid, List<TransactionType> transactions)
        {
            // Проверка действительночти токена
            if (!LibUser.CheckToken(token, _context))
                return StatusCode(421, "Invalid token");

            User? user = LibUser.GetUserByToken(token, _context);
            return Json(LibTransaction.GetTransactionsByUser(user, _context));
        }

    }
}
