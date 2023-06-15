import 'package:budget_tracker/widgets/home_screen/home_features.dart';
import 'package:flutter/material.dart';
import '../../widgets/general/drawer_default.dart';
import '../../widgets/home_screen/home_header.dart';
import '../../widgets/home_screen/home_tips.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const name = '/home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Página Inicial',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const DrawerDefault(),
      body: const Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            HomeHeader(),
            HomeFeatures(),
            HomeTips(),
          ],
        ),
      ),
    );
  }
}
