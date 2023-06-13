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

        [Range(0, double.MaxValue, ErrorMessage = "O valor deve ser maior que zero.")]
        public double TotalAmount { get; set; }
        public int Entries { get; set; }

        public int Icon { get; set; }
    }
}
