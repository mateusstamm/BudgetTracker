import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/img/home_bg.png',
        ),
        SizedBox(height: 16),
        Align(
          alignment: Alignment.center,
          child: Text(
            'BUDGET TRACKER',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
