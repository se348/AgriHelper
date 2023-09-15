using AgriHelper.Core.Models;
using Microsoft.EntityFrameworkCore;

namespace AgriHelper.Infrastructure
{
    public class AgriHelperDbContext: DbContext
    {
        public AgriHelperDbContext(DbContextOptions<AgriHelperDbContext> options) : base(options)
        {
        }

        public DbSet<Farm> Farms { get; set; }
        public DbSet<FarmUser> FarmUsers { get; set; }
        public DbSet<Field> Fields { get; set; }
        public DbSet<Notification> Notifications { get; set; }
        public DbSet<Sensor> Sensors { get; set; }

        public DbSet<SensorResetDate> SensorResetDates { get; set; }
        public DbSet<User> Users { get; set; }

        public DbSet<SensorDateInformation> SensorDateInformations { get; set; }


        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlServer("Server=(localdb)\\mssqllocaldb;Database=AgriHelper;Trusted_Connection=True;MultipleActiveResultSets=true");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Farm>().ToTable(nameof(Farm));
            modelBuilder.Entity<FarmUser>().ToTable(nameof(FarmUser));
            modelBuilder.Entity<Field>().ToTable(nameof(Field));
            modelBuilder.Entity<Notification>().ToTable(nameof(Notification));
            modelBuilder.Entity<Sensor>().ToTable(nameof(Sensor));
            modelBuilder.Entity<SensorResetDate>().ToTable(nameof(SensorResetDate));
            modelBuilder.Entity<User>().ToTable(nameof(User));
            modelBuilder.Entity<SensorDateInformation>().ToTable(nameof(SensorDateInformation));    
        }
    }
}
