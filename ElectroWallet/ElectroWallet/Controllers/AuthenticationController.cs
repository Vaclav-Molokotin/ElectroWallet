using ElectroWallet.Libs;
using ElectroWallet.Models;
using Microsoft.AspNetCore.Mvc;
using System.Globalization;

namespace ElectroWallet.Controllers
{
    public class AuthenticationController : Controller
    {
        private ApplicationContext _context;
        public AuthenticationController(ApplicationContext context)
        {
           _context = context;
        }

        [HttpPost("/api/register")]
        public IActionResult Register(string login, string password)
        {
            User? userData = LibUser.GetUserByLogin(login, _context);
            if (userData != null)
            {
                return StatusCode(420, "User already exists");
            }

            User user = new User { Login = login, Password = password, CreationDate = DateTime.Now };

            if(LibUser.CreateUser(user, _context))
                return Ok("Successfully registered");
            else
                return StatusCode(420, "InvalidData");
        }

        [HttpPost("/api/login")]
        public IActionResult Login(string login, string password)
        {

            User? user = LibUser.GetUserByLogin(login, _context);
            if (user != null)
            {
                Response.StatusCode = 200;
                return Ok(user.TokenAPI);
            }

            return StatusCode(420, "Invalid login or password");
        }
    }
}
