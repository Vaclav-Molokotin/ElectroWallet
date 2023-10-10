

using ElectroWallet.Models;

namespace ElectroWallet.Libs
{
    public static class LibTransaction
    {
        public static int AddTransaction(Transaction transaction, ApplicationContext context)
        {
            try
            {
                context.Transactions.Add(transaction);
                context.SaveChanges();

                return 0;
            }
            catch
            {
                return -1;
            }
        }

        public static List<Transaction> GetTransactionsByUser(User user, ApplicationContext context)
        {
            return context.Transactions.Where(p => p.Wallet.UserID == user.ID).ToList();
        }
    }
}
