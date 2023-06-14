import 'package:budget_tracker/screens/categories/category_screen.dart';
import 'package:budget_tracker/screens/configurations/config_screen.dart';
import 'package:budget_tracker/screens/expenses/expense_screen.dart';
import 'package:budget_tracker/screens/home/home_screen.dart';
import 'package:budget_tracker/screens/login/login_screen.dart';
import 'package:budget_tracker/screens/register/register_screen.dart';
import 'package:budget_tracker/widgets/general/custom_theme.dart';
import 'package:budget_tracker/widgets/general/theme_model.dart';
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
        },
      ),
    );
  }
}
