import 'package:flutter/material.dart';
import '../../widgets/category_screen/category_fetcher.dart';
import '../../widgets/drawer_default.dart';
import '../../widgets/expense_form.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});
  static const name = '/expenses_screen'; // for routes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      drawer: DrawerDefault(),
      body: const CategoryFetcher(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /*showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => ExpenseForm(),
          );*/
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
