using ElectroWallet.Models;
using Microsoft.EntityFrameworkCore;

namespace ElectroWallet.Libs
{
    public static class LibUser
    {
        public static bool UpdateUser(User userData, ApplicationContext context)
        {
            User? user = context.Users.FirstOrDefault(p => p.ID == userData.ID);
            if (user == null) 
            {
                throw new Exception("Пользователя не существует в базе данных");
            }

            context.Users.Update(userData);
            try
            {
                context.SaveChanges();
            }
            catch
            {
                return false;
            }

            return true;
        }

        public static bool CreateUser(User userData, ApplicationContext context)
        {
            if(userData == null)
            {
                return false;
            }

            User? user = context.Users.FirstOrDefault(u => u.ID == userData.ID);
            if (user != null) 
            {
                return false;
            }

            userData.TokenAPI = LibJWT.CreateToken(userData);

            context.Users.Add(userData);

            try
            {
                context.SaveChanges();
                return true;
            }
            catch { return false; }
        }

        public static User? GetUserByID(int id, ApplicationContext context)
        {
            return context.Users.FirstOrDefault(p => p.ID == id);
        }

        public static User? GetUserByLogin(string login, ApplicationContext context)
        {
            return context.Users.FirstOrDefault(p => p.Login == login);
        }

        public static User? GetUserByToken(string token, ApplicationContext context)
        {
            return context.Users.FirstOrDefault(p => p.TokenAPI == token);
        }

        public static bool CheckToken(string token, ApplicationContext context)
        {
            User? user = context.Users.FirstOrDefault(p => p.TokenAPI == token);

            if (user != null)
            {
                return true;
            }

            return false;
        }
    }
}
