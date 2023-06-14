import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../data/user/datasources/remote_api/user_login.dart';
import '../../data/user/datasources/remote_api/user_register.dart';
import '../../data/user/models/user_model.dart';
import '../../data/user/repositories/user_repository.dart';
import '../home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const name = '/login_register'; // for routes
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final UserRepository _userRepository = UserRepository(
    UserLoginDataSource(),
    UserRegisterDataSource(),
  );
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: 'First Name',
              ),
            ),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: 'Last Name',
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final firstName = _firstNameController.text;
                final lastName = _lastNameController.text;
                final email = _emailController.text;
                final password = _passwordController.text;

                final user = UserModel(
                  firstName: firstName,
                  lastName: lastName,
                  email: email,
                  password: password,
                );

                _userRegister(user);
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _userRegister(UserModel user) async {
    final success = await _userRepository.register(user);
    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Credenciais de login inválidas',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}
