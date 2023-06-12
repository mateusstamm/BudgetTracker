import 'package:flutter/material.dart';

import '../../data/datasources/remote_api/expense.dart';
import '../../models/expense_model.dart';

class ExpenseForm extends StatefulWidget {
  final ExpenseDataSource expenseDataSource;

  const ExpenseForm({Key? key, required this.expenseDataSource})
      : super(key: key);

  @override
  _ExpenseFormState createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = '';

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Widget _buildCategoryDropdown() {
    return FutureBuilder<List<String>>(
      future: widget.expenseDataSource.getCategories(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final categories = snapshot.data!;
          return DropdownButtonFormField<String>(
            value: _selectedCategory,
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategory = newValue!;
              });
            },
            items: categories.map<DropdownMenuItem<String>>((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: 'Categoria',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Selecione uma categoria';
              }
              return null;
            },
          );
        } else if (snapshot.hasError) {
          return Text('Failed to load categories');
        }
        return CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Digite um nome';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Descrição',
              ),
            ),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantia',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Digite uma quantia';
                }
                return null;
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Data'),
              subtitle: Text(
                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
              onTap: () => _selectDate(context),
            ),
            _buildCategoryDropdown(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final expense = ExpenseModel(
                    title: _nameController.text,
                    amount: double.parse(_amountController.text),
                    date: _selectedDate,
                    categoryID: int.tryParse(_selectedCategory),
                  );

                  try {
                    await widget.expenseDataSource.addExpense(expense);
                    Navigator.of(context).pop();
                  } catch (error) {
                    print('Failed to add expense: $error');
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content:
                            Text('Failed to add expense. Please try again.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                }
              },
              child: Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }
}
