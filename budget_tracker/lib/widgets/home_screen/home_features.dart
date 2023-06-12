import 'package:flutter/material.dart';

class HomeFeatures extends StatelessWidget {
  const HomeFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 16),
        Text(
          'Funcionalidades Disponíveis',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Text(
          '• Registros de Gastos',
        ),
        SizedBox(height: 8),
        Text(
          '• Criação e Vinculação de Categorias',
        ),
        SizedBox(height: 8),
        Text(
          '• Análise de Gráficos das Despesas',
        ),
        SizedBox(height: 8),
        Text(
          '• Customização da Interface Gráfica',
        ),
      ],
    );
  }
}
