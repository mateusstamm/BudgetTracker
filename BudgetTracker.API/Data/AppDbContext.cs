
using Microsoft.EntityFrameworkCore;
using Pomelo.EntityFrameworkCore.MySql.Infrastructure;
using BudgetTracker.API.Models;

public class AppDbContext : DbContext
{
    // Defina suas entidades como DbSet
    public DbSet<UserModel>? Users { get; set; }
    public DbSet<CategoryModel>? Categories { get; set; }
    public DbSet<ExpenseModel>? Expenses { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        var serverVersion = new MySqlServerVersion(new Version(8, 0, 31)); // Especifique a versão correta do servidor MySQL aqui

        optionsBuilder.UseMySql("Server=database;Port=3306;Database=budgettracker_db;User=root;Password=budgettracker;",
            serverVersion,
            options => options.EnableRetryOnFailure());
    }

}