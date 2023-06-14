import 'package:flutter/material.dart';
import '../../widgets/general/drawer_default.dart';
import '../../widgets/expense_screen/expense_form.dart';
import '../../widgets/expense_screen/expense_chart.dart';
import '../../widgets/expense_screen/expense_category_list.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({Key? key}) : super(key: key);
  static const String name = '/expense_screen'; // for routes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Despesas',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      drawer: DrawerDefault(),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: ExpenseChart(),
            ),
          ),
          Expanded(
            flex: 3,
            child: ExpenseCategoryList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => ExpenseForm(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
