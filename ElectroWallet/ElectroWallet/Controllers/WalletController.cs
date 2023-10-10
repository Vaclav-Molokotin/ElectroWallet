using ElectroWallet.Libs;
using ElectroWallet.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Html;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ElectroWallet.Controllers
{
    public class WalletController : Controller
    {
        private ApplicationContext _context;
        public WalletController(ApplicationContext context)
        {
            _context = context;
        }

        [HttpPost("api/CreateWallet")]
        public IActionResult CreateWallet([FromQuery] string token, [FromQuery] string currencyCode, [FromQuery] string name)
        {
            // Проверка действительночти токена
            if (!LibUser.CheckToken(token, _context))
                return StatusCode(421, "Invalid token");

            User? user = LibUser.GetUserByToken(token, _context);
            var currency = _context.Currencies.FirstOrDefault(p => p.Code == currencyCode);

            Wallet wallet = new Wallet
            {
                UserID = user.ID,
                User = user,
                CurrencyType = currency,
                Name = name,
                Id = new Guid()
            };

            int result = LibWallet.CreateWallet(wallet, _context);

            switch (result)
            {
                case -2:
                    return StatusCode(422, "Wallet name already exists");
                case -1:
                    return StatusCode(420, "Invalid data");
                default:
                    return Ok();
            }

        }

        [HttpPost("api/GetWallets")]
        public IActionResult GetWallets([FromQuery] string token)
        {
            // Проверка действительночти токена
            if (!LibUser.CheckToken(token, _context))
                return StatusCode(421, "Invalid token");

            User? user = LibUser.GetUserByToken(token, _context);

            List<Wallet>? wallets = LibWallet.GetWalletsByUser(user, _context);

            if (wallets == null)
                return StatusCode(420, "No Wallets");

            Response.StatusCode = 200;
            return Json(wallets);
        }

        [HttpPost("api/TopUpWallet")]
        public IActionResult TopUpWallet([FromQuery] string token, Guid walletGuid, string accountDetails, float amount)
        {
            // Проверка действительночти токена
            if (!LibUser.CheckToken(token, _context))
                return StatusCode(421, "Invalid token");

            // Проверка существования кошелька
            Wallet? wallet = LibWallet.GetWalletByGuid(walletGuid, _context);
            if (wallet == null)
                return StatusCode(420, "Incorrect walletGuid");

            // Здесь должна быть логика выставления счетов на оплату

            //
            int result = LibWallet.UpdateBalance(wallet, amount, _context);

            switch (result)
            {
                case -2:
                    return StatusCode(501, "Server error");
                default:
                    return Ok();
            }
        }


        [HttpPost("api/Transfer")]
        public IActionResult Transfer([FromQuery] string token, [FromQuery] Guid walletGuid, [FromQuery] string accountDetails, [FromQuery] float amount)
        {
            // Проверка действительночти токена
            if (!LibUser.CheckToken(token, _context))
                return StatusCode(421, "Invalid token");

            // Проверка существования кошелька
            Wallet? wallet = LibWallet.GetWalletByGuid(walletGuid, _context);
            if (wallet == null)
                return StatusCode(422, "Incorrect walletGuid");

            // Здесь должна быть логика перевода денежных средств

            //

            int result = LibWallet.UpdateBalance(wallet, -amount, _context);

            switch (result)
            {
                case -1:
                    return StatusCode(423, "Not enough money");
                case -2:
                    return StatusCode(501, "Server error");
                default:
                    return Ok();
            }

        }

        [HttpPost("api/TransferWallet")]
        public IActionResult Transfer([FromQuery] string token, [FromQuery] Guid walletGuid_From, [FromQuery] Guid walletGuid_To, [FromQuery] float amount)
        {
            // Проверка действительночти токена
            if (!LibUser.CheckToken(token, _context))
                return StatusCode(421, "Invalid token");

            // Проверка существования кошельков
            Wallet? walletFrom = LibWallet.GetWalletByGuid(walletGuid_From, _context);
            Wallet? walletTo = LibWallet.GetWalletByGuid(walletGuid_To, _context);
            if (walletFrom == null && walletTo == null)
                return StatusCode(422, "Incorrect walletGuid");

            // Здесь должна быть логика перевода денежных средств

            //

            int resultFrom = LibWallet.UpdateBalance(walletFrom, -amount, _context);
            int resultTo = LibWallet.UpdateBalance(walletTo, amount, _context);

            Transaction transaction = new Transaction { WalletID = walletFrom.Id, BillTo = walletTo.Id.ToString(), TransactionTypeID = 2, Amount = amount };

            switch (resultFrom)
            {
                case -1:
                    transaction.StatusID = 1;
                    return StatusCode(423, "Not enough money");
                case -2:
                    transaction.StatusID = 4;
                    return StatusCode(501, "Server error");
            }

            switch (resultTo)
            {
                case -2:
                    transaction.StatusID = 4;
                    return StatusCode(501, "Server error");
            }
            transaction.StatusID = 2;
            LibTransaction.AddTransaction(transaction, _context);
            return Ok();
        }

        [HttpPost("api/CloseWallet")]
        public IActionResult CloseWallet([FromQuery] string token, [FromQuery] Guid walletGuid)
        {
            // Проверка действительночти токена
            if (!LibUser.CheckToken(token, _context))
                return StatusCode(421, "Invalid token");

            // Проверка существования кошельков
            Wallet? wallet = LibWallet.GetWalletByGuid(walletGuid, _context);
            if (wallet == null)
                return StatusCode(422, "Incorrect walletGuid");

            int result = LibWallet.DeleteWallet(walletGuid, _context);
            switch (result)
            {
                case -1:
                    return StatusCode(501, "Server error");
                default:
                    return Ok();
            }
        }
    }
}
