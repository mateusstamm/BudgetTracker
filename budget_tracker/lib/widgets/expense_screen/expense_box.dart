import 'package:flutter/material.dart';
import '../../data/datasources/remote_api/expense.dart';
import '../../models/expense.dart';

class ConfirmBox extends StatelessWidget {
  const ConfirmBox({
    Key? key,
    required this.expense,
    required this.dataSource,
  }) : super(key: key);

  final Expense expense;
  final ExpenseDataSource dataSource;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete ${expense.title} ?'),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // don't delete
            },
            child: const Text('Don\'t delete'),
          ),
          const SizedBox(width: 5.0),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop(true); // delete
              try {
                //await dataSource.deleteExpense(expense.id);
                // Perform any additional actions after deleting the expense
              } catch (e) {
                // Handle error while deleting the expense
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
