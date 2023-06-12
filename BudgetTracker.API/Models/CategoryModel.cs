using System.ComponentModel.DataAnnotations;

namespace BudgetTracker.API.Models
{
    public class CategoryModel
    {
        [Key]
        public int CategoryID { get; set; }

        [Required(ErrorMessage = "O campo Título é obrigatório.")]
        public string ?Title { get; set; }

        public string ?Description { get; set; }

        public double TotalAmount { get; set; }

        public int Icon { get; set; }
    }
}
