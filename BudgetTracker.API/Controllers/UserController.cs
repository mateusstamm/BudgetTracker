using System.Linq;
using Microsoft.AspNetCore.Mvc;
using BudgetTracker.API.DTO;
using BudgetTracker.API.Models;

namespace BudgetTracker.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserController : ControllerBase
    {
        private readonly AppDbContext _context;

        public UserController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult GetAllUsers()
        {
            var users = _context.Users!.ToList();
            return Ok(users);
        }

        [HttpPost]
        public IActionResult AddUser(UserDTO userDTO)
        {
            var newUser = new UserModel
            {
                FirstName = userDTO.FirstName,
                LastName = userDTO.LastName,
                Email = userDTO.Email,
                Password = userDTO.Password
            };

            _context.Users!.Add(newUser);
            _context.SaveChanges();

            return CreatedAtAction(nameof(GetUserById), new { id = newUser.UserID }, newUser);
        }

        [HttpGet("{id}")]
        public IActionResult GetUserById(int id)
        {
            var user = _context.Users!.FirstOrDefault(u => u.UserID == id);

            if (user == null)
            {
                return NotFound("Usuário não encontrado.");
            }

            return Ok(user);
        }

        [HttpPut("{id}")]
        public IActionResult UpdateUser(int id, UserDTO userDTO)
        {
            var user = _context.Users!.FirstOrDefault(u => u.UserID == id);

            if (user == null)
            {
                return NotFound("Usuário não encontrado.");
            }

            user.FirstName = userDTO.FirstName;
            user.LastName = userDTO.LastName;
            user.Email = userDTO.Email;
            user.Password = userDTO.Password;

            _context.SaveChanges();

            return NoContent();
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteUser(int id)
        {
            var user = _context.Users!.FirstOrDefault(u => u.UserID == id);

            if (user == null)
            {
                return NotFound("Usuário não encontrado.");
            }

            _context.Users!.Remove(user);
            _context.SaveChanges();

            return NoContent();
        }

        [HttpPost]
        [Route("/register")]
        public IActionResult Register([FromBody] UserModel userModel)
        {
            // Verifique se o modelo de usuário é válido
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // Verifique se o email já está em uso
            if (_context.Users!.Any(u => u.Email == userModel.Email))
            {
                return Conflict("O email já está em uso.");
            }

            // Crie um novo usuário com base no modelo
            var user = new UserModel
            {
                FirstName = userModel.FirstName,
                LastName = userModel.LastName,
                Email = userModel.Email,
                Password = userModel.Password
            };

            // Adicione o usuário ao contexto do banco de dados
            _context.Users!.Add(user);
            _context.SaveChanges();

            // Retorne uma resposta de sucesso com o ID do novo usuário
            return Ok(new { UserID = user.UserID });
        }

        [HttpPost]
        [Route("/login")]
        public IActionResult Login([FromBody] LoginModel loginModel)
        {
            // Verifique se o modelo de login é válido
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // Verifique se as credenciais de login são válidas
            var user = _context.Users!.SingleOrDefault(u => u.Email == loginModel.Email && u.Password == loginModel.Password);

            if (user == null)
            {
                return Unauthorized("Credenciais de login inválidas.");
            }

            // Gerar um token de autenticação (exemplo básico)
            string token = GenerateToken(user.UserID);

            // Retorne uma resposta de sucesso com o token de autenticação
            return Ok(new { Token = token });
        }

        private string GenerateToken(int userId)
        {
            // Lógica para gerar um token (exemplo básico)
            string token = "seu_token_de_autenticacao_" + userId.ToString();

            return token;
        }
    }
}