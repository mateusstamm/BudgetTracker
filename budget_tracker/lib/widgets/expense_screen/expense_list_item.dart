import 'package:flutter/material.dart';

import '../../data/datasources/remote_api/expense.dart';
import '../../models/expense_model.dart';

class ExpenseListItem extends StatefulWidget {
  @override
  _ExpenseListItemState createState() => _ExpenseListItemState();
}

class _ExpenseListItemState extends State<ExpenseListItem> {
  final ExpenseDataSource _expenseDataSource = ExpenseDataSource();
  List<ExpenseModel> expenses = [];

  @override
  void initState() {
    super.initState();
    fetchExpenses();
  }

  Future<void> fetchExpenses() async {
    try {
      final List<ExpenseModel> fetchedExpenses =
          await _expenseDataSource.getAllExpenses();
      setState(() {
        expenses = fetchedExpenses;
      });
    } catch (error) {
      print('Failed to fetch expenses: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];
        return ListTile(
          leading: Text(expense.description!),
          title: Text(expense.title!),
          subtitle: Text('Amount: \$${expense.amount!.toStringAsFixed(2)}'),
          trailing: Text('Date: ${expense.date}'),
        );
      },
    );
  }
}
