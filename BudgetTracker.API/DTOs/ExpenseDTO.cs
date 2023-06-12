namespace BudgetTracker.API.DTO
{
    public class ExpenseDTO
    {
        public int ExpenseID { get; set; }

        public string ?Title { get; set; }
        public string ?Description { get; set; }

        public double Amount { get; set; }

        public DateTime Date { get; set; }

        public CategoryDTO? Category { get; set; }
    }
}
