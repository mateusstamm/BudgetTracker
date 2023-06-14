import 'package:http/http.dart' as http;
import 'dart:convert';

class UserDataSource {
  static Future<bool> userLogin(String email, String password) async {
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

  Future<bool> userRegister({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2/register'), // Altere a URL para a sua API
      body: jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    return response.statusCode == 200;
  }
}
