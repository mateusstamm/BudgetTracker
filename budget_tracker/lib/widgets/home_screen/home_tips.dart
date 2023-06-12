import 'package:flutter/material.dart';

class HomeTips extends StatelessWidget {
  const HomeTips({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 16),
        Text(
          'Dicas para Poupar Dinheiro',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Text(
          '• Faça um orçamento mensal e siga-o rigorosamente.',
        ),
        SizedBox(height: 8),
        Text(
          '• Evite gastos supérfluos e impulsivos.',
        ),
        SizedBox(height: 8),
        Text(
          '• Procure economizar em despesas fixas, como aluguel e contas de energia.',
        ),
        SizedBox(height: 8),
        Text(
          '• Use cupons e aproveite promoções ao fazer compras.',
        ),
        SizedBox(height: 8),
        Text(
          '• Cozinhe em casa em vez de comer fora.',
        ),
        SizedBox(height: 8),
        Text(
          '• Cancele assinaturas ou serviços desnecessários.',
        ),
        SizedBox(height: 8),
        Text(
          '• Crie metas financeiras de curto e longo prazo.',
        ),
        SizedBox(height: 8),
        Text(
          '• Poupe uma porcentagem do seu salário todo mês.',
        ),
      ],
    );
  }
}
