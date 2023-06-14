import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../../data/datasources/remote_api/user_data_source.dart';
import '../../screens/login/login_screen.dart';
import '../general/custom_alert.dart';
import 'package:flutter/services.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  String? firstNameErrorText;
  String? lastNameErrorText;
  String? emailErrorText;
  String? passwordErrorText;

  void _togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      isConfirmPasswordVisible = !isConfirmPasswordVisible;
    });
  }

  void _register() async {
    final String firstName = firstNameController.text;
    final String lastName = lastNameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    if (firstName.isEmpty) {
      setState(() {
        firstNameErrorText = 'Insira um nome! Campo obrigatório.';
      });
      return;
    } else {
      setState(() {
        firstNameErrorText = null;
      });
    }

    if (lastName.isEmpty) {
      setState(() {
        lastNameErrorText = 'Insira um sobrenome! Campo obrigatório.';
      });
      return;
    } else {
      setState(() {
        lastNameErrorText = null;
      });
    }

    if (!validateName(firstName)) {
      setState(() {
        firstNameErrorText =
            'Insira um nome válido! Apenas letras são permitidas.';
      });
      return;
    } else {
      setState(() {
        firstNameErrorText = null;
      });
    }

    if (!validateName(lastName)) {
      setState(() {
        lastNameErrorText =
            'Insira um sobrenome válido! Apenas letras são permitidas.';
      });
      return;
    } else {
      setState(() {
        lastNameErrorText = null;
      });
    }

    if (email.isEmpty) {
      setState(() {
        emailErrorText = 'Insira um e-mail! Campo obrigatório.';
      });
      return;
    } else {
      setState(() {
        emailErrorText = null;
      });
    }

    if (!EmailValidator.validate(email)) {
      setState(() {
        emailErrorText = 'E-mail inválido. Digite um e-mail válido.';
      });
      return;
    } else {
      setState(() {
        emailErrorText = null;
      });
    }

    if (password.isEmpty) {
      setState(() {
        passwordErrorText = 'Insira uma senha! Campo obrigatório.';
      });
      return;
    } else {
      setState(() {
        passwordErrorText = null;
      });
    }

    if (!validatePassword(password)) {
      setState(() {
        passwordErrorText =
            'Senha inválida. A senha deve ter pelo menos 8 caracteres, uma letra maiúscula, '
            'um caractere especial (@#!\$%*) e um número.';
      });
      return;
    } else {
      setState(() {
        passwordErrorText = null;
      });
    }

    if (confirmPassword.isEmpty) {
      setState(() {
        passwordErrorText = 'Confirme sua senha! Campo obrigatório.';
      });
      return;
    } else {
      setState(() {
        passwordErrorText = null;
      });
    }

    if (password != confirmPassword) {
      setState(() {
        passwordErrorText = 'As senhas não coincidem';
      });
      return;
    } else {
      setState(() {
        passwordErrorText = null;
      });
    }

    final dataSource = UserDataSource();
    final registerSuccess = await dataSource.userRegister(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );

    if (registerSuccess) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlert(
            title: 'Sucesso!',
            message: 'Registro realizado com sucesso!\nFaça seu login agora.',
          );
        },
      ).then((value) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginScreen.name,
          (route) => false,
        );
      });
    } else {
      _showErrorAlert('Erro', 'Falha no registro');
    }
  }

  bool validateName(String name) {
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z]+$');
    return nameRegExp.hasMatch(name);
  }

  bool validatePassword(String password) {
    final RegExp passwordRegExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$%*])[a-zA-Z0-9!@#\$%*]{8,}$');
    return passwordRegExp.hasMatch(password);
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
          controller: firstNameController,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
          ],
          decoration: InputDecoration(
            labelText: 'Nome',
            errorText: firstNameErrorText,
          ),
        ),
        const SizedBox(height: 16.0),
        TextField(
          controller: lastNameController,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
          ],
          decoration: InputDecoration(
            labelText: 'Sobrenome',
            errorText: lastNameErrorText,
          ),
        ),
        const SizedBox(height: 16.0),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: emailErrorText,
          ),
        ),
        const SizedBox(height: 16.0),
        TextField(
          controller: passwordController,
          obscureText: !isPasswordVisible,
          decoration: InputDecoration(
            labelText: 'Senha',
            errorText: passwordErrorText,
            suffixIcon: GestureDetector(
              onTap: _togglePasswordVisibility,
              child: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        TextField(
          controller: confirmPasswordController,
          obscureText: !isConfirmPasswordVisible,
          decoration: InputDecoration(
            labelText: 'Confirmar Senha',
            suffixIcon: GestureDetector(
              onTap: _toggleConfirmPasswordVisibility,
              child: Icon(
                isConfirmPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32.0),
        ElevatedButton(
          onPressed: _register,
          child: const Text('Registrar'),
        ),
      ],
    );
  }
}
