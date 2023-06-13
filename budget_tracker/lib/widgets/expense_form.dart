import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/category_model.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({Key? key}) : super(key: key);

  @override
  _ExpenseFormState createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _amountController;
  late TextEditingController _dateController;
  int? _selectedCategoryId;
  List<CategoryModel> categories = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _amountController = TextEditingController();
    _dateController = TextEditingController();
    fetchCategories(); // Fetch categories from API when the form is initialized
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> fetchCategories() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2/api/category'));
      if (response.statusCode == 200) {
        final body = json.decode(response.body) as List<dynamic>;
        final List<CategoryModel> fetchedCategories =
            body.map((item) => CategoryModel.fromJson(item)).toList();
        setState(() {
          categories = fetchedCategories;
        });
      } else {
        print(
            'Failed to fetch categories. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Failed to fetch categories: $error');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = picked.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Nome'),
            controller: _nameController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor, insira um nome.';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Descrição'),
            controller: _descriptionController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor, insira uma descrição.';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Valor'),
            controller: _amountController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor, insira um valor.';
              }
              if (double.tryParse(value) == null) {
                return 'Por favor, insira um valor válido.';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          GestureDetector(
            onTap: () {
              _selectDate(context);
            },
            child: AbsorbPointer(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Data',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                controller: _dateController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, selecione uma data.';
                  }
                  return null;
                },
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Categoria',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          DropdownButtonFormField<int>(
            value: _selectedCategoryId,
            onChanged: (int? categoryId) {
              setState(() {
                _selectedCategoryId = categoryId;
              });
            },
            items: categories.map((CategoryModel category) {
              return DropdownMenuItem<int>(
                value: category.categoryID,
                child: Text(category.categoryName),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
