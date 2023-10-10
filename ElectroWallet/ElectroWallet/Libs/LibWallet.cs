using ElectroWallet.Models;

namespace ElectroWallet.Libs
{
    public static class LibWallet
    {
        /// <summary>
        /// Метод. Создаёт кошелек по переданной модели
        /// </summary>
        /// <param name="walletData">Модель кошелька</param>
        /// <param name="context">Контекст БД</param>
        /// <returns>0 - создан, -1 - null, -2 - кошелек с таким именем уже существует</returns>
        public static int CreateWallet(Wallet walletData, ApplicationContext context)
        {
            
            if(walletData == null)
            {
                return -1;
            }

            // Проверяем, существует ли кошелек с таким же именем
            Wallet? wallet = context.Wallets.FirstOrDefault(p => p.Name == walletData.Name && p.UserID == walletData.UserID);

            if(wallet != null)
            {
                return -2;
            }

            context.Wallets.Add(walletData);
            context.SaveChanges();

            return 0;
        }

        public static List<Wallet>? GetWalletsByUser(User user, ApplicationContext context)
        {
            return context.Wallets.Where(p => p.User == user).ToList();
        }

        public static Wallet? GetWalletByGuid(Guid guid, ApplicationContext context)
        {
            return context.Wallets.FirstOrDefault(p => p.Id == guid);
        }

        /// <summary>
        /// Метод. Пополняет или списывает баланс кошелька пользователя.
        /// </summary>
        /// <param name="walletData">Модель кошелька</param>
        /// <param name="amount">Сумма пополнения (положительная или отрицательная)</param>
        /// <param name="context">Контекст БД</param>
        /// <returns>-2 - Не удалось сохранить изменения, -1 - недостаточно средств для списания, 0 - успешно</returns>
        public static int UpdateBalance(Wallet walletData, float amount, ApplicationContext context) 
        {
            if(amount < 0 && Math.Abs(amount) > walletData.Amount)
            {
                return -1;
            }

            walletData.Amount += amount;
            try
            {
                context.Wallets.Update(walletData);
                context.SaveChanges();
            }
            catch
            {
                return -2;
            }

            return 0;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="guid"></param>
        /// <param name="context"></param>
        /// <returns>-2 - null, -1 - Ошибка удаления, 0 - удалено</returns>
        public static int DeleteWallet(Guid guid, ApplicationContext context)
        {
            Wallet? wallet = context.Wallets.FirstOrDefault(p=> p.Id == guid);
            if(wallet == null)
            {
                return -2;
            }

            try
            {
                context.Wallets.Remove(wallet);
                context.SaveChanges();

                return 0;
            }
            catch
            {
                return -1;
            }
        }
    }
}
