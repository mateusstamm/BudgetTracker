import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/datasources/remote_api/category_data_source.dart';
import '../../data/datasources/remote_api/expense_data_source.dart';
import '../../models/category_model.dart';
import '../../models/expense_model.dart';

class ExpenseForm extends StatefulWidget {
  @override
  _ExpenseFormState createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  CategoryModel? _selectedCategory;
  List<CategoryModel> _categories = []; // Lista de categorias disponíveis

  @override
  void initState() {
    super.initState();
    fetchCategories(); // Buscar as categorias disponíveis ao iniciar o formulário
  }

  Future<void> fetchCategories() async {
    try {
      final categories = await CategoryDataSource().fetchCategories();
      setState(() {
        _categories = categories;
      });
    } catch (error) {
      // Trate o erro de busca das categorias conforme necessário
    }
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now()
          .subtract(Duration(days: 365)), // Defina o limite para 1 ano atrás
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';

    final formattedDate = DateFormat('dd/MM/yyyy').format(date);
    return formattedDate;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final String title = _titleController.text;
      final String description = _descriptionController.text;
      final double amount = _amountController.text.isNotEmpty
          ? double.parse(_amountController.text)
          : 0.0;

      final CategoryModel selectedCategory = _selectedCategory!;

      final ExpenseModel expense = ExpenseModel(
        expenseID: 0, // Valor padrão para expenseID
        title: title,
        description: description,
        amount: amount.toDouble(),
        date: _selectedDate!,
        category: selectedCategory,
      );

      try {
        await ExpenseDataSource().addExpense(expense);
        // Realize qualquer ação necessária após adicionar a despesa
      } catch (error) {
        // Trate o erro de adição de despesa conforme necessário
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, informe o título da despesa.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Valor'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, informe o valor da despesa.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.0),
              InkWell(
                onTap: _selectDate,
                child: IgnorePointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Data',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, informe a data da despesa.';
                      }
                      return null;
                    },
                    controller:
                        TextEditingController(text: _formatDate(_selectedDate)),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Categoria',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<CategoryModel>(
                value: _selectedCategory,
                onChanged: (CategoryModel? category) {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
                items: _categories.map((CategoryModel category) {
                  return DropdownMenuItem<CategoryModel>(
                    value: category,
                    child: Text(category.categoryName),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Por favor, selecione uma categoria.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
