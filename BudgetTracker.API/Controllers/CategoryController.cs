using System.Collections.Generic;
using System.Linq;
using BudgetTracker.API.DTO;
using BudgetTracker.API.Models;
using Microsoft.AspNetCore.Mvc;

namespace BudgetTracker.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CategoryController : ControllerBase
    {
        private readonly AppDbContext _context;

        public CategoryController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult GetAllCategories()
        {
            List<CategoryDTO> categoryDTOs = _context.Categories!.Select(c => new CategoryDTO
            {
                CategoryID = c.CategoryID,
                Title = c.Title,
                Description = c.Description,
                TotalAmount = c.TotalAmount,
                Entries = c.Entries,
                Icon = c.Icon,
                ExpenseCount = _context.Expenses!.Count(e => e.Category!.CategoryID == c.CategoryID)
            }).ToList();

            return Ok(categoryDTOs);
        }

        [HttpGet("{id}")]
        public IActionResult GetCategoryById(int id)
        {
            CategoryModel category = _context.Categories!.FirstOrDefault(c => c.CategoryID == id)!;
            if (category == null)
                return NotFound();

            CategoryDTO categoryDTO = new CategoryDTO
            {
                CategoryID = category.CategoryID,
                Title = category.Title,
                Description = category.Description,
                TotalAmount = category.TotalAmount,
                Entries = category.Entries,
                Icon = category.Icon,
                ExpenseCount = _context.Expenses!.Count(e => e.Category!.CategoryID == category.CategoryID)
            };

            return Ok(categoryDTO);
        }

        [HttpPost]
        public IActionResult CreateCategory(CategoryDTO categoryDTO)
        {
            CategoryModel category = new CategoryModel
            {
                Title = categoryDTO.Title,
                Description = categoryDTO.Description,
                TotalAmount = categoryDTO.TotalAmount,
                Entries = categoryDTO.Entries,
                Icon = categoryDTO.Icon
            };

            _context.Categories!.Add(category);
            _context.SaveChanges();

            categoryDTO.CategoryID = category.CategoryID;

            return CreatedAtAction(nameof(GetCategoryById), new { id = category.CategoryID }, categoryDTO);
        }

        [HttpPut("{id}")]
        public IActionResult UpdateCategory(int id, CategoryDTO categoryDTO)
        {
            CategoryModel category = _context.Categories!.FirstOrDefault(c => c.CategoryID == id)!;
            if (category == null)
                return NotFound();

            category.Title = categoryDTO.Title;
            category.Description = categoryDTO.Description;
            category.TotalAmount = categoryDTO.TotalAmount;
            category.Icon = categoryDTO.Icon;

            _context.SaveChanges();

            return NoContent();
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteCategory(int id)
        {
            CategoryModel category = _context.Categories!.FirstOrDefault(c => c.CategoryID == id)!;
            if (category == null)
                return NotFound();

            _context.Categories!.Remove(category);
            _context.SaveChanges();

            return NoContent();
        }
    }
}
