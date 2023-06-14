import 'package:flutter/material.dart';
import '../../data/datasources/remote_api/user.dart';
import '../general/custom_alert.dart';

class LoginForm extends StatefulWidget {
  final Function onLoginSuccess;

  const LoginForm({Key? key, required this.onLoginSuccess}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool showErrorMessages = false;

  void _togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void _login() async {
    final String email = emailController.text;
    final String password = passwordController.text;

    setState(() {
      showErrorMessages = true;
    });

    if (email.isNotEmpty && password.isNotEmpty) {
      final success = await UserDataSource.userLogin(email, password);

      if (success) {
        widget.onLoginSuccess();
      } else {
        _showErrorAlert('Erro', 'Email ou senha incorretos!');
      }
    }
  }

  void _showErrorAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlert(title: title, message: message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: showErrorMessages && emailController.text.isEmpty
                ? 'O preenchimento deste campo é obrigatório!'
                : null,
          ),
        ),
        const SizedBox(height: 16.0),
        TextField(
          controller: passwordController,
          obscureText: !isPasswordVisible,
          decoration: InputDecoration(
            labelText: 'Senha',
            suffixIcon: GestureDetector(
              onTap: _togglePasswordVisibility,
              child: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
            ),
            errorText: showErrorMessages && passwordController.text.isEmpty
                ? 'O preenchimento deste campo é obrigatório!'
                : null,
          ),
        ),
        const SizedBox(height: 32.0),
        ElevatedButton(
          onPressed: _login,
          child: const Text('Login'),
        ),
      ],
    );
  }
}
