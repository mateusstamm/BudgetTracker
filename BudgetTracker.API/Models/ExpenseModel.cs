using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace BudgetTracker.API.Models
{
    public class ExpenseModel
    {
        [Key]
        public int ExpenseID { get; set; }

        [Required(ErrorMessage = "O campo Título é obrigatório.")]
        public string? Title { get; set; }
        public string? Description { get; set; }

        [Required(ErrorMessage = "O campo Valor é obrigatório.")]
        [Range(0, double.MaxValue, ErrorMessage = "O valor deve ser maior que zero.")]
        public double Amount { get; set; }

        [Required(ErrorMessage = "O campo Data é obrigatório.")]
        public DateTime Date { get; set; }

        [ForeignKey("CategoryID")]
        public int CategoryID { get; set; } // Chave estrangeira

        public CategoryModel? Category { get; set; } // Propriedade de navegação
    }
}
