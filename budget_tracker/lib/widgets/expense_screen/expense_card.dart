import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/datasources/remote_api/expense.dart';
import '../../models/expense.dart';
import '../../constants/icons.dart';
import 'expense_box.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;

  const ExpenseCard(this.expense, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataSource = ExpenseDataSource();

    return Dismissible(
      key: ValueKey(expense.id),
      confirmDismiss: (_) async {
        showDialog(
          context: context,
          builder: (_) => ConfirmBox(expense: expense, dataSource: dataSource),
        );
        return null;
      },
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icons[expense.category]),
        ),
        title: Text(expense.title),
        subtitle: Text(DateFormat('MMMM dd, yyyy').format(expense.date)),
        trailing: Text(
          NumberFormat.currency(locale: 'en_IN', symbol: '₹')
              .format(expense.amount),
        ),
      ),
    );
  }
}
