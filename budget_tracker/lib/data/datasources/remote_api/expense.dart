import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../models/expense_model.dart';

class ExpenseDataSource {
  final String _baseUrl = 'http://10.0.2.2/api/expense';

  Future<List<ExpenseModel>> getAllExpenses() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl'));

      if (response.statusCode == 200) {
        final List<dynamic> responseBody = json.decode(response.body);
        final List<ExpenseModel> expenses = responseBody
            .map((expense) => ExpenseModel.fromJson(expense))
            .toList();
        return expenses;
      } else {
        print('Failed to fetch expenses. Status code: ${response.statusCode}');
        throw 'Failed to fetch expenses. Status code: ${response.statusCode}';
      }
    } catch (error) {
      print('Failed to fetch expenses: $error');
      throw 'Failed to fetch expenses: $error';
    }
  }

  Future<List<String>> getCategories() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2/api/category'));

      if (response.statusCode == 200) {
        final body = json.decode(response.body) as List<dynamic>;
        final categories = body.map((item) => item.toString()).toList();
        return categories;
      } else {
        print(
            'Failed to fetch categories. Status code: ${response.statusCode}');
        throw 'Failed to fetch categories. Status code: ${response.statusCode}';
      }
    } catch (error) {
      print('Failed to fetch categories: $error');
      throw 'Failed to fetch categories: $error';
    }
  }

  Future<ExpenseModel> addExpense(ExpenseModel expense) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(expense.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = json.decode(response.body);
        final newExpense = ExpenseModel.fromJson(responseBody);
        return newExpense;
      } else {
        print('Failed to add expense. Status code: ${response.statusCode}');
        throw 'Failed to add expense. Status code: ${response.statusCode}';
      }
    } catch (error) {
      print('Failed to add expense: $error');
      throw 'Failed to add expense: $error';
    }
  }

  Future<ExpenseModel> updateExpense(
      ExpenseModel oldExpense, ExpenseModel newExpense) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/${oldExpense.expenseID}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(newExpense.toJson()),
      );

      if (response.statusCode == 200) {
        final updatedExpense =
            ExpenseModel.fromJson(json.decode(response.body));
        return updatedExpense;
      } else {
        print('Failed to update expense. Status code: ${response.statusCode}');
        throw 'Failed to update expense. Status code: ${response.statusCode}';
      }
    } catch (error) {
      print('Failed to update expense: $error');
      throw 'Failed to update expense: $error';
    }
  }

  Future<void> deleteExpense(ExpenseModel expense) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/${expense.expenseID}'),
      );

      if (response.statusCode != 200) {
        print('Failed to delete expense. Status code: ${response.statusCode}');
        throw 'Failed to delete expense. Status code: ${response.statusCode}';
      }
    } catch (error) {
      print('Failed to delete expense: $error');
      throw 'Failed to delete expense: $error';
    }
  }
}
