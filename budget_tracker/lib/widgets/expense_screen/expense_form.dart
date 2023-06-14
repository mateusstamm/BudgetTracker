import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../../data/datasources/remote_api/category_data_source.dart';
import '../../data/datasources/remote_api/expense_data_source.dart';
import '../../models/category_model.dart';
import '../../models/expense_model.dart';
import '../../screens/expenses/expense_screen.dart';

class ExpenseForm extends StatefulWidget {
  final ExpenseModel? expenseToEdit;

  ExpenseForm({this.expenseToEdit});

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
  List<CategoryModel> _categories = [];
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    fetchCategories();
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        _isKeyboardVisible = visible;
      });
    });

    if (widget.expenseToEdit != null) {
      _initFormValues();
    }
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

  void _initFormValues() {
    final expense = widget.expenseToEdit!;
    _titleController.text = expense.title!;
    _descriptionController.text = expense.description!;
    _amountController.text = expense.amount.toString();
    _selectedDate = expense.date;
    //_selectedCategory = expense.category;
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 365)),
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
        expenseID: widget.expenseToEdit?.expenseID ?? 0,
        title: title,
        description: description,
        amount: amount.toDouble(),
        date: _selectedDate!,
        category: selectedCategory,
      );

      try {
        if (widget.expenseToEdit != null) {
          await ExpenseDataSource()
              .updateExpense(widget.expenseToEdit!, expense);
        } else {
          await ExpenseDataSource().addExpense(expense);
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ExpenseScreen()),
        );
      } catch (error) {
        // Trate o erro de adição ou atualização da despesa conforme necessário
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Fecha o teclado quando o usuário tocar fora dos campos de entrada
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.expenseToEdit != null
              ? 'Editar Despesa'
              : 'Adicionar Despesa'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Título'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, insira um título';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Descrição'),
                  ),
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Valor'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, insira um valor';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Por favor, insira um valor válido';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: _selectDate,
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 8.0),
                        Text(
                          'Data: ${_formatDate(_selectedDate)}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  DropdownButtonFormField<CategoryModel>(
                    value: _selectedCategory,
                    items: _categories.map((category) {
                      return DropdownMenuItem<CategoryModel>(
                        value: category,
                        child: Text(category.categoryName),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Categoria',
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Por favor, selecione uma categoria';
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
        ),
      ),
    );
  }
}
