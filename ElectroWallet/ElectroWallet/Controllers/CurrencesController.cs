using ElectroWallet.Libs;
using ElectroWallet.Models;
using Microsoft.AspNetCore.Mvc;

namespace ElectroWallet.Controllers
{
    public class CurrencesController : Controller
    {
        private ApplicationContext _context;
        public CurrencesController(ApplicationContext context)
        {
            _context = context;
        }

        [HttpPost("api/GetCurrencies")]
        public IActionResult GetCurrencies(string token)
        {
            // Проверка действительночти токена
            if (!LibUser.CheckToken(token, _context))
                return StatusCode(421, "Invalid token");

            return Json(LibCurrency.GetCurrencies(_context));
        }
    }
}
