namespace BudgetTracker.API.DTO
{
    public class CategoryDTO
    {
        public int CategoryID { get; set; }
        public string ?Title { get; set; }
        public string ?Description { get; set; }
        public double TotalAmount { get; set; }
        public int Icon { get; set; }
        public int ExpenseCount { get; set; }
    }
}
