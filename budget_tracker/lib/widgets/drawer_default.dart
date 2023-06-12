import 'package:flutter/material.dart';

import '../screens/categories/category_list.dart';
import '../screens/configurations/config_screen.dart';
import '../screens/expenses/expense_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/login/login_screen.dart';

class DrawerDefault extends StatelessWidget {
  const DrawerDefault({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeMode currentThemeMode =
        Theme.of(context).brightness == Brightness.dark
            ? ThemeMode.dark
            : ThemeMode.light;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: currentThemeMode == ThemeMode.dark
                  ? Colors.grey[900]
                  : const Color.fromARGB(255, 46, 118, 49),
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
                ExpenseScreen.name,
                (route) => false,
              );
            },
          ),
          ListTile(
            title: const Text('Categorias'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                CategoryList.name,
                (route) => false,
              );
            },
          ),
          ListTile(
            title: const Text('Configurações'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                ConfigScreen.name,
                (route) => false,
              );
            },
          ),
          ListTile(
            title: const Text('Sair'),
            onTap: () {
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
