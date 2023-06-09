using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace BudgetTracker.API.Models
{
    public class UserModel
    {
        [Key]
        public int UserID { get; set; }

        [Required(ErrorMessage = "O campo Nome é obrigatório.")]
        public string ?FirstName { get; set; }

        [Required(ErrorMessage = "O campo Sobrenome é obrigatório.")]
        public string ?LastName { get; set; }

        [Required(ErrorMessage = "O campo Email é obrigatório.")]
        [EmailAddress(ErrorMessage = "O campo Email deve ser um endereço de email válido.")]
        public string ?Email { get; set; }

        [Required(ErrorMessage = "O campo Senha é obrigatório.")]
        public string ?Password { get; set; }
    }
}