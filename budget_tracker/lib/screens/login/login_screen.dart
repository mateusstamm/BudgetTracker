import 'package:flutter/material.dart';
import '../../widgets/login_screen/login_header.dart';
import '../home/home_screen.dart';
import '../register/register_screen.dart';
import '../../widgets/login_screen/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const name = '/login_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LoginHeaderWidget(),
            LoginForm(
              onLoginSuccess: () {
                Navigator.pushNamed(context, HomeScreen.name);
              },
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterScreen(),
                  ),
                );
              },
              child: const Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
