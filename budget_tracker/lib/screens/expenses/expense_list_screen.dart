import 'package:flutter/material.dart';
import '../../widgets/expense_screen/expense_list_item.dart';

class ExpenseListScreen extends StatelessWidget {
  const ExpenseListScreen({Key? key}) : super(key: key);
  static const String name = '/expense_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todas as Despesas',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ExpenseListItem(),
          Center(
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: const Text(
                'Deslize para deletar',
                style: TextStyle(
                    fontSize: 16.0, color: Color.fromARGB(72, 185, 185, 185)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
