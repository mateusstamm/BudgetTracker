using System.Linq;
using Microsoft.AspNetCore.Mvc;
using BudgetTracker.API.DTO;
using BudgetTracker.API.Models;

namespace BudgetTracker.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ExpenseController : ControllerBase
    {
        private readonly AppDbContext _context;

        public ExpenseController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult GetAllExpenses()
        {
            var expenses = _context.Expenses!.ToList();
            return Ok(expenses);
        }

        [HttpPost]
        public IActionResult AddExpense(ExpenseDTO expenseDTO)
        {
            var newExpense = new ExpenseModel
            {
                Title = expenseDTO.Title,
                Amount = expenseDTO.Amount,
                Date = expenseDTO.Date,
                Category = expenseDTO.Category
            };

            _context.Expenses!.Add(newExpense);
            _context.SaveChanges();

            return CreatedAtAction(nameof(GetExpenseById), new { id = newExpense.ExpenseID }, newExpense);
        }

        [HttpGet("{id}")]
        public IActionResult GetExpenseById(int id)
        {
            var expense = _context.Expenses!.FirstOrDefault(e => e.ExpenseID == id);

            if (expense == null)
            {
                return NotFound("Despesa não encontrada.");
            }

            return Ok(expense);
        }

        [HttpPut("{id}")]
        public IActionResult UpdateExpense(int id, ExpenseDTO expenseDTO)
        {
            var expense = _context.Expenses!.FirstOrDefault(e => e.ExpenseID == id);

            if (expense == null)
            {
                return NotFound("Despesa não encontrada.");
            }

            expense.Title = expenseDTO.Title;
            expense.Amount = expenseDTO.Amount;
            expense.Date = expenseDTO.Date;
            expense.Category = expenseDTO.Category;

            _context.SaveChanges();

            return NoContent();
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteExpense(int id)
        {
            var expense = _context.Expenses!.FirstOrDefault(e => e.ExpenseID == id);

            if (expense == null)
            {
                return NotFound("Despesa não encontrada.");
            }

            _context.Expenses!.Remove(expense);
            _context.SaveChanges();

            return NoContent();
        }
    }
}