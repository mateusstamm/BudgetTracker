import 'package:expense_app/screens/home_screen.dart';
import 'package:expense_app/screens/login_screen.dart';
import 'package:expense_app/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './models/database_provider.dart';
// screens
import './screens/category_screen.dart';
import './screens/expense_screen.dart';
import './screens/all_expenses.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => DatabaseProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.name,
      routes: {
        RegisterScreen.name: (_) => const RegisterScreen(),
        LoginScreen.name: (_) => const LoginScreen(),
        HomeScreen.name: (_) => const HomeScreen(),
        CategoryScreen.name: (_) => const CategoryScreen(),
        ExpenseScreen.name: (_) => const ExpenseScreen(),
        AllExpenses.name: (_) => const AllExpenses(),
      },
    );
  }
}
