using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace BudgetTracker.API.Models
{
    public class ExpenseModel
    {
        [Key]
        public int ExpenseID { get; set; }

        [Required(ErrorMessage = "O campo Título é obrigatório.")]
        public string ?Title { get; set; }

        [Required(ErrorMessage = "O campo Valor é obrigatório.")]
        [Range(0, double.MaxValue, ErrorMessage = "O valor deve ser maior que zero.")]
        public double Amount { get; set; }

        [Required(ErrorMessage = "O campo Data é obrigatório.")]
        public DateTime Date { get; set; }

        [Required(ErrorMessage = "O campo Categoria é obrigatório.")]
        public string ?Category { get; set; }
    }
}