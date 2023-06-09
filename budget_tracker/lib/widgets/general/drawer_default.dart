import 'package:flutter/material.dart';

import '../../screens/categories/category_screen.dart';
import '../../screens/configurations/config_screen.dart';
import '../../screens/expenses/expense_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/login/login_screen.dart';

class DrawerDefault extends StatelessWidget {
  const DrawerDefault({Key? key}) : super(key: key);

  String _getCurrentRoute(BuildContext context) {
    final ModalRoute<dynamic>? modalRoute = ModalRoute.of(context);
    return modalRoute?.settings.name ?? '';
  }

  Widget _buildDrawerItem(
    BuildContext context,
    String title,
    String routeName,
  ) {
    final String currentPage = _getCurrentRoute(context);
    final bool isSelected = currentPage == routeName;

    return Container(
      color: isSelected ? Colors.grey[300] : null,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.black : null,
          ),
        ),
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            routeName,
            (route) => false,
          );
        },
        selected: isSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeMode currentThemeMode =
        Theme.of(context).brightness == Brightness.dark
            ? ThemeMode.dark
            : ThemeMode.light;

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: currentThemeMode == ThemeMode.dark
                  ? Colors.grey[900]
                  : const Color.fromARGB(255, 46, 118, 49),
            ),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                '••• MENU •••',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  context,
                  'Página Inicial',
                  HomeScreen.name,
                ),
                _buildDrawerItem(
                  context,
                  'Despesas',
                  ExpenseScreen.name,
                ),
                _buildDrawerItem(
                  context,
                  'Categorias',
                  CategoryList.name,
                ),
                _buildDrawerItem(
                  context,
                  'Configurações',
                  ConfigScreen.name,
                ),
                _buildDrawerItem(
                  context,
                  'Sair',
                  LoginScreen.name,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: const Center(
              child: Text(
                'Mateus Stamm - UTFPR/MD - TDS/2023',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
