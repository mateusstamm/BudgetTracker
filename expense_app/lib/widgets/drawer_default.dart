import 'package:flutter/material.dart';
import '../screens/categories/category_screen.dart';
import '../screens/expenses/expense_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login/login_screen.dart';

class DrawerDefault extends StatelessWidget {
  const DrawerDefault({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Página Inicial'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                HomeScreen.name,
                (route) => false,
              );
            },
          ),
          ListTile(
            title: const Text('Despesas'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                ExpensesScreen.name,
                (route) => false,
              );
            },
          ),
          ListTile(
            title: const Text('Categorias'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                CategoryScreen.name,
                (route) => false,
              );
            },
          ),
          ListTile(
            title: const Text('Configurações'),
            onTap: () {
              // Implemente a lógica para navegar para a tela de configurações aqui
            },
          ),
          ListTile(
            title: const Text('Sair'),
            onTap: () {
              // Implemente a lógica de logout aqui
              // Por exemplo, limpe o token de autenticação e redirecione para a tela de login
              Navigator.pushNamedAndRemoveUntil(
                context,
                LoginScreen.name,
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
