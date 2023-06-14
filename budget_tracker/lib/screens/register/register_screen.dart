import 'package:flutter/material.dart';

import '../../widgets/register_screen/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  static const name = '/register_screen'; // for routes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'FAÇA SEU REGISTRO!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            RegisterForm(),
          ],
        ),
      ),
    );
  }
}
