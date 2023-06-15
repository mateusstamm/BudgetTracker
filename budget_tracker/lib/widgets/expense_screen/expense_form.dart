import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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

  @override
  void initState() {
    super.initState();
    fetchCategories();

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
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
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

  bool _validateAmount(String value) {
    final RegExp amountRegExp = RegExp(r'^\d*\.?\d+$');
    return amountRegExp.hasMatch(value);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final String title = _titleController.text;
      final String description = _descriptionController.text;
      final String amountText = _amountController.text;
      final double amount = double.parse(amountText);

      final CategoryModel selectedCategory = _selectedCategory!;

      final ExpenseModel expense = ExpenseModel(
        expenseID: widget.expenseToEdit?.expenseID ?? 0,
        title: title,
        description: description,
        amount: amount,
        date: _selectedDate!,
        category: selectedCategory,
      );

      try {
        if (widget.expenseToEdit != null) {
          final ExpenseModel expenseToEdit = widget.expenseToEdit!;

          if (expenseToEdit.category!.categoryID ==
              selectedCategory.categoryID) {
            // Categoria não foi alterada, fazer apenas o PUT
            ExpenseDataSource().updateExpense(expenseToEdit, expense);
          } else {
            // Categoria foi alterada, fazer o PUT e o UPDATE para a categoria antiga
            //CategoryDataSource()
            //    .updateCategory(expenseToEdit.category!, expense.category!);
            ExpenseDataSource().updateExpense(expenseToEdit, expense);

            final CategoryModel oldCategory = expenseToEdit.category!;
            final CategoryModel updatedCategory = CategoryModel(
              categoryID: oldCategory.categoryID,
              categoryName: oldCategory.categoryName,
              categoryDescription: oldCategory.categoryDescription,
              totalAmount: oldCategory.totalAmount! - expenseToEdit.amount!,
              entries: oldCategory.entries! - 1,
              icon: oldCategory.icon,
            );

            CategoryDataSource().updateCategory(oldCategory, updatedCategory);
          }
        } else {
          ExpenseDataSource().addExpense(expense);
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
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Título'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, insira um título';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Descrição'),
                  ),
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d+$')),
                    ],
                    decoration: const InputDecoration(labelText: 'Valor'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, insira um valor';
                      }
                      if (!_validateAmount(value)) {
                        return 'Por favor, insira um valor válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: _selectDate,
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today),
                        const SizedBox(width: 8.0),
                        Text(
                          'Data: ${_formatDate(_selectedDate)}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
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
                    decoration: const InputDecoration(
                      labelText: 'Categoria',
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Por favor, selecione uma categoria';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Salvar'),
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
