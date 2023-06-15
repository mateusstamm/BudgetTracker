using System.Linq;
using Microsoft.AspNetCore.Mvc;
using BudgetTracker.API.DTO;
using BudgetTracker.API.Models;
using Microsoft.EntityFrameworkCore;

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
            var expenses = _context.Expenses!
                .Include(e => e.Category)
                .ToList();

            var expenseDTOs = expenses.Select(e => new ExpenseDTO
            {
                ExpenseID = e.ExpenseID,
                Title = e.Title,
                Description = e.Description,
                Amount = e.Amount,
                Date = e.Date,
                Category = new CategoryDTO
                {
                    CategoryID = e.Category!.CategoryID,
                    Title = e.Category?.Title,
                    Description = e.Category?.Description,
                    TotalAmount = e.Category!.TotalAmount,
                    Entries = e.Category!.Entries,
                    Icon = e.Category.Icon
                }
            }).ToList();

            return Ok(expenseDTOs);
        }

        [HttpGet("{id}")]
        public IActionResult GetExpenseById(int id)
        {
            var expense = _context.Expenses!
                .Include(e => e.Category)
                .FirstOrDefault(e => e.ExpenseID == id);

            if (expense == null)
            {
                return NotFound("Despesa não encontrada.");
            }

            var expenseDTO = new ExpenseDTO
            {
                ExpenseID = expense.ExpenseID,
                Title = expense.Title,
                Description = expense.Description,
                Amount = expense.Amount,
                Date = expense.Date,
                Category = expense.Category != null ? new CategoryDTO
                {
                    CategoryID = expense.Category.CategoryID,
                    Title = expense.Category.Title,
                    Description = expense.Category.Description,
                    TotalAmount = expense.Category.TotalAmount,
                    Entries = expense.Category.Entries,
                    Icon = expense.Category.Icon
                } : null
            };

            return Ok(expenseDTO);
        }

        [HttpPost]
        public IActionResult AddExpense(ExpenseDTO expenseDTO)
        {
            var category = _context.Categories!.Find(expenseDTO.Category!.CategoryID);

            if (category == null)
            {
                return BadRequest("Categoria inválida.");
            }

            var newExpense = new ExpenseModel
            {
                Title = expenseDTO.Title,
                Description = expenseDTO.Description,
                Amount = expenseDTO.Amount,
                Date = expenseDTO.Date,
                Category = category
            };

            _context.Expenses!.Add(newExpense);

            // Atualizar o totalAmount da categoria
            category.TotalAmount += expenseDTO.Amount;

            // Incrementar a propriedade Entries da categoria em 1
            UpdateCategoryEntries(category.CategoryID, 1);

            _context.SaveChanges();

            expenseDTO.ExpenseID = newExpense.ExpenseID;

            return CreatedAtAction(nameof(GetExpenseById), new { id = newExpense.ExpenseID }, expenseDTO);
        }

        [HttpPut("{id}")]
        public IActionResult UpdateExpense(int id, ExpenseDTO expenseDTO)
        {
            var expense = _context.Expenses!.FirstOrDefault(e => e.ExpenseID == id);

            if (expense == null)
            {
                return NotFound("Despesa não encontrada.");
            }

            var category = _context.Categories!.Find(expenseDTO.Category!.CategoryID);

            if (category == null)
            {
                return BadRequest("Categoria inválida.");
            }

            
            // Atualizar o totalAmount da categoria
            expenseDTO.Category.TotalAmount -= expense.Amount; // Subtrair o valor antigo da categoria antiga
            category.TotalAmount += expenseDTO.Amount; // Adicionar o novo valor da despesa

            expenseDTO.Category.TotalAmount += expenseDTO.Amount;
            

            // Atualizar Entries da categoria            
            UpdateCategoryEntries(expense.CategoryID, -1); // Remove uma Entrie da categoria antiga
            UpdateCategoryEntries(expenseDTO.Category.CategoryID, 1); // Adiciona uma Entrie na categoria nova

            expense.Title = expenseDTO.Title;
            expense.Description = expenseDTO.Description;
            expense.Amount = expenseDTO.Amount;
            expense.Date = expenseDTO.Date;
            expense.Category = category;

            _context.SaveChanges();

            return NoContent();
        }
		
		[HttpGet("category/{categoryId}")]
		public IActionResult GetExpensesByCategory(int categoryId)
		{
			var expenses = _context.Expenses!
				.Include(e => e.Category)
				.Where(e => e.CategoryID == categoryId)
				.ToList();

			var expenseDTOs = expenses.Select(e => new ExpenseDTO
			{
				ExpenseID = e.ExpenseID,
				Title = e.Title,
				Description = e.Description,
				Amount = e.Amount,
				Date = e.Date,
				Category = new CategoryDTO
				{
					CategoryID = e.Category!.CategoryID,
					Title = e.Category?.Title,
					Description = e.Category?.Description,
					TotalAmount = e.Category!.TotalAmount,
					Entries = e.Category!.Entries,
					Icon = e.Category.Icon
				}
			}).ToList();

			return Ok(expenseDTOs);
		}

		
        [HttpDelete("{id}")]
        public IActionResult DeleteExpense(int id)
        {
            var expense = _context.Expenses!.FirstOrDefault(e => e.ExpenseID == id);

            if (expense == null)
            {
                return NotFound("Despesa não encontrada.");
            }

            var categoryId = expense.CategoryID;

            _context.Expenses!.Remove(expense);

            // Atualizar o totalAmount da categoria
            var category = _context.Categories!.FirstOrDefault(c => c.CategoryID == categoryId);

            if (category != null)
            {
                category.TotalAmount -= expense.Amount;

                // Decrementar a propriedade Entries da categoria em 1
                UpdateCategoryEntries(categoryId, -1);

                _context.SaveChanges();
            }

            return NoContent();
        }

        private void UpdateCategoryEntries(int categoryId, int changeAmount)
        {
            var category = _context.Categories!.FirstOrDefault(c => c.CategoryID == categoryId);

            if (category != null)
            {
                category.Entries += changeAmount;
                _context.SaveChanges();
            }
        }

        private void UpdateCategoryTotalAmount(int categoryId, int changeAmount)
        {
            var category = _context.Categories!.FirstOrDefault(c => c.CategoryID == categoryId);

            if (category != null)
            {
                category.TotalAmount += changeAmount;
                _context.SaveChanges();
            }
        }
    }
}
