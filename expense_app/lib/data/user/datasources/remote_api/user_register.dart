import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRegisterDataSource {
  Future<bool> register(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
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

    if (response.statusCode == 200) {
      // Lógica de registro bem-sucedido
      print('Registro bem-sucedido');
      return true;
    } else {
      // Lógica de registro falhou
      print('Falha no registro');
      return false;
    }
  }
}
