using Microsoft.EntityFrameworkCore;

namespace ElectroWallet.Models
{
    public class ApplicationContext : DbContext
    {
        public DbSet<User> Users { get; set; } = null!;
        public DbSet<Wallet> Wallets { get; set; } = null!;
        public DbSet<Currency> Currencies { get; set; } = null!;
        public DbSet<Status> Statuses { get; set; } = null!;
        public DbSet<TransactionType> TransactionTypes { get; set; } = null!;
        public DbSet<Transaction> Transactions { get; set; } = null!;


        /// <summary>
        /// Констркутор. Задаёт параметры контекста БД, а также пересоздаёт БД в SqlServer.
        /// </summary>
        /// <param name="options">Параметры контекста БД</param>
        public ApplicationContext(DbContextOptions<ApplicationContext> options)
            : base(options)
        {
            Database.EnsureCreated();

        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Currency>().HasKey(u => new { u.Code });
        }
    }
}
