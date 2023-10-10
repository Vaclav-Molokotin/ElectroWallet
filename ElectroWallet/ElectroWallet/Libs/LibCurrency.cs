using ElectroWallet.Models;

namespace ElectroWallet.Libs
{
    public static class LibCurrency
    {
        public static List<Currency> GetCurrencies(ApplicationContext context)
        {
            return context.Currencies.ToList();
        }
    }
}
