import 'package:flutter/material.dart';

class ExpenseCategoryNotFound extends StatelessWidget {
  final VoidCallback onCreateCategory;

  const ExpenseCategoryNotFound({required this.onCreateCategory});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Não existem categorias.\n\nQue tal criar uma?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0),
          ),
          ElevatedButton(
            onPressed: onCreateCategory,
            child: const Text('Criar Agora!'),
          ),
        ],
      ),
    );
  }
}
