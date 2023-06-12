import 'package:flutter/material.dart';
import '../../models/expense.dart';
import 'expense_card.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseList(this.expenses, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return expenses.isNotEmpty
        ? ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (_, i) => ExpenseCard(expenses[i]),
          )
        : const Center(
            child: Text('No Expenses Added'),
          );
  }
}
