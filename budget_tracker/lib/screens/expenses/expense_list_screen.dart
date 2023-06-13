import 'package:flutter/material.dart';
import '../../widgets/drawer_default.dart';
import '../../widgets/expense_screen/expense_list_item.dart';

class ExpenseListScreen extends StatelessWidget {
  const ExpenseListScreen({Key? key}) : super(key: key);
  static const String name = '/expense_screen'; // for routes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todas as Despesas'),
      ),
      body: ExpenseListItem(),
    );
  }
}
