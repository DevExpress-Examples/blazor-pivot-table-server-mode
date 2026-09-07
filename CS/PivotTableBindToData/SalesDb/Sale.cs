#nullable disable

namespace PivotTableBindToData.SalesDb {
    public partial class Sale {
        public int SaleId { get; set; }
        public int StoreNumber { get; set; }
        public string StoreName { get; set; }
        public DateTime? SaleDate { get; set; }
        public int? Year { get; set; }
        public int? Quarter { get; set; }
        public decimal? Amount { get; set; }
    }
}
