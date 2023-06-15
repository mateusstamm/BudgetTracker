import 'package:flutter/material.dart';
import 'home_carousel.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: HomeCarousel(),
        ),
        const SizedBox(height: 16),
        const Align(
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
