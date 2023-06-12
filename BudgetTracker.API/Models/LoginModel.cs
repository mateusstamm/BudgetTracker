using System.ComponentModel.DataAnnotations;

namespace BudgetTracker.API.Models
{
    public class LoginModel
    {
        [Required(ErrorMessage = "O campo Email é obrigatório.")]
        [EmailAddress(ErrorMessage = "O campo Email deve ser um endereço de email válido.")]
        public string ?Email { get; set; }

        [Required(ErrorMessage = "O campo Senha é obrigatório.")]
        public string ?Password { get; set; }
    }
}