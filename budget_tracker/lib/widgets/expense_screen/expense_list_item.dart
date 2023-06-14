import 'package:flutter/material.dart';
import '../../data/datasources/remote_api/expense_data_source.dart';
import '../../models/expense_model.dart';
import '../../screens/expenses/expense_screen.dart';

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
        return Dismissible(
          key: Key(expense.expenseID.toString()),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 16.0),
            color: Colors.red,
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          confirmDismiss: (direction) async {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Confirmação'),
                  content: const Text(
                      'Tem certeza de que deseja excluir esta despesa?'),
                  actions: [
                    TextButton(
                      child: const Text('Não'),
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                    ),
                    TextButton(
                      child: const Text('Sim'),
                      onPressed: () async {
                        await deleteExpense(expense);
                        Navigator.pop(context, true);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExpenseScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Adicione aqui a ação para editar a despesa
                      },
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${expense.title}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 8.0),
                          ],
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '${_truncateDescription(expense.description!)}',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${_formatDate(expense.date)}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'R\$${expense.amount!.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _truncateDescription(String description) {
    if (description.length > 20) {
      return description.substring(0, 20) + '...';
    }
    return description;
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}';
  }

  Future<void> deleteExpense(ExpenseModel expense) async {
    try {
      await _expenseDataSource.deleteExpense(expense);
      setState(() {
        expenses.remove(expense);
      });
      print('Expense deleted successfully.');
    } catch (error) {
      print('Failed to delete expense: $error');
    }
  }
}
