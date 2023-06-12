import 'package:budget_tracker/screens/all_expenses.dart';
import 'package:budget_tracker/screens/categories/category_list.dart';
import 'package:budget_tracker/screens/configurations/config_screen.dart';
import 'package:budget_tracker/screens/expense_graph.dart';
import 'package:budget_tracker/screens/expenses/expense_screen.dart';
import 'package:budget_tracker/screens/home/home_screen.dart';
import 'package:budget_tracker/screens/login/login_screen.dart';
import 'package:budget_tracker/screens/register/register_screen.dart';
import 'package:budget_tracker/widgets/custom_theme.dart';
import 'package:budget_tracker/widgets/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => ThemeModel(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, themeModel, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeModel.darkModeEnabled
            ? CustomTheme.darkThemeData
            : CustomTheme.themeData,
        initialRoute: LoginScreen.name,
        routes: {
          RegisterScreen.name: (_) => const RegisterScreen(),
          LoginScreen.name: (_) => const LoginScreen(),
          HomeScreen.name: (_) => const HomeScreen(),
          CategoryList.name: (_) => const CategoryList(),
          ConfigScreen.name: (_) => const ConfigScreen(),
          ExpenseScreen.name: (_) => const ExpenseScreen(),
          ExpenseGraph.name: (_) => const ExpenseGraph(),
          AllExpenses.name: (_) => const AllExpenses(),
        },
      ),
    );
  }
}
