import 'dart:convert';
import 'package:http/http.dart' as http;

class UserLoginDataSource {
  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2/login'), // Altere a URL para a sua API
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Lógica de autenticação bem-sucedida
      print('Login bem-sucedido');
      return true;
    } else {
      // Lógica de autenticação falhou
      print('Falha no login');
      return false;
    }
  }
}
