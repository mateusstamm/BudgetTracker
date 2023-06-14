import 'package:flutter/material.dart';
import '../../screens/categories/category_screen.dart';

class ExpenseCategoryNotFound extends StatelessWidget {
  final VoidCallback onCreateCategory;

  const ExpenseCategoryNotFound({required this.onCreateCategory});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Não existem categorias.\n\nQue tal criar uma?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0),
          ),
          ElevatedButton(
            onPressed: onCreateCategory,
            child: Text('Criar Agora!'),
          ),
        ],
      ),
    );
  }
}
