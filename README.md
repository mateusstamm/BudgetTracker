# BudgetTracker




# Funcionalidades Principais
- Autenticação: Registro e Login: Os usuários podem se cadastrar no aplicativo fornecendo um endereço de e-mail e uma senha segura. 
- Registro de Despesas: Os usuários podem adicionar suas despesas, incluindo título, descrição, valor, data e categoria.
- Gerenciamento de Categorias: É possível criar, editar e excluir categorias para organizar as despesas de acordo com as preferências do usuário.
- Relatórios e Estatísticas: Os usuários podem visualizar relatórios detalhados de suas despesas, incluindo gráficos e análises para uma melhor compreensão dos seus padrões de gastos.

# Tecnologias Utilizadas
O BudgetTracker utiliza as seguintes tecnologias:

- Flutter: Um framework de desenvolvimento de aplicativos multiplataforma que nos permite criar aplicativos nativos para iOS e Android a partir de um único código-base.
- Dart: A linguagem de programação utilizada pelo Flutter para escrever a lógica do aplicativo.
- Docker: Uma plataforma de virtualização que permite empacotar e distribuir aplicativos com todas as suas dependências em um contêiner. 
- C# WebAPI: O BudgetTracker utiliza uma API web desenvolvida em C#, uma linguagem de programação poderosa e versátil.
- 

# Funcionamento

- Clone o repositório em sua máquina;
- Substitua o IP 10.0.2.2 (utilizado em testes) pelo IP da máquina hospedeira Docker, dentro dos projetos;
- Na raíz dê o comando "docker-compose up -d --build" para realizar o build da aplicação;
- Comunicação padrão do banco de dados ocorre na porta 3306 e API na porta 80;