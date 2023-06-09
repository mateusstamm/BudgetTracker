namespace BudgetTracker.API.DTO;
public class ExpenseDTO
{
    public string ?Title { get; set; }
    public double Amount { get; set; }
    public DateTime Date { get; set; }
    public string ?Category { get; set; }
}
