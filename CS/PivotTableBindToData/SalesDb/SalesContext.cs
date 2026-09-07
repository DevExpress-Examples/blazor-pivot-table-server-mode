using Microsoft.EntityFrameworkCore;

#nullable disable

namespace PivotTableBindToData.SalesDb {
    public partial class SalesContext : DbContext {

        public SalesContext(DbContextOptions<SalesContext> options)
            : base(options) {
        }

        public virtual DbSet<Sale> Sales { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder) {
            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
