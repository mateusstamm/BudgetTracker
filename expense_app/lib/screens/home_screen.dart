import 'package:flutter/material.dart';
import '../widgets/drawer_default.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});
  static const name = '/home_screen'; // for routes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: DrawerDefault(),
      body: const Center(
        child: Text('Bem-vindo à tela inicial!'),
      ),
    );
  }
}
