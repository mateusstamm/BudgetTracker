import 'package:flutter/material.dart';

import '../../widgets/register_screen/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key});
  static const String name = '/register_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
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
      ),
    );
  }
}
