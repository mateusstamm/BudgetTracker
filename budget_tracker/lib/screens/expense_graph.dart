import 'package:flutter/material.dart';
import '../widgets/expense_screen2/expense_fetcher.dart';

class ExpenseGraph extends StatelessWidget {
  const ExpenseGraph({super.key});
  static const name = '/expense_graph';
  @override
  Widget build(BuildContext context) {
    // get the argument passed from category_card.
    final category = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: const Text('Expense Graph')),
      body: ExpenseFetcher(category),
    );
  }
}
