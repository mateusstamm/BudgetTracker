import 'package:flutter/material.dart';
import '../../data/datasources/remote_api/expense_data_source.dart';
import '../../models/category_model.dart';
import '../../widgets/expense_screen/expense_category_not_found.dart';
import '../../widgets/general/drawer_default.dart';
import '../../widgets/expense_screen/expense_form.dart';
import '../../widgets/expense_screen/expense_chart.dart';
import '../../widgets/expense_screen/expense_category_list.dart';
import '../../screens/categories/category_screen.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key? key}) : super(key: key);
  static const String name = '/expense_screen'; // for routes

  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  late Future<List<CategoryModel>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = _fetchCategories();
  }

  Future<List<CategoryModel>> _fetchCategories() async {
    try {
      final expenseDataSource = ExpenseDataSource();
      return await expenseDataSource.getAllCategories();
    } catch (error) {
      print('Failed to fetch categories: $error');
      throw 'Failed to fetch categories: $error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Despesas',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const DrawerDefault(),
      body: FutureBuilder<List<CategoryModel>>(
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final categories = snapshot.data!;

            if (categories.isEmpty) {
              return ExpenseCategoryNotFound(
                onCreateCategory: () {
                  Navigator.pushNamed(context, CategoryList.name);
                },
              );
            }

            return Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: const ExpenseChart(),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ExpenseCategoryList(),
                ),
              ],
            );
          } else {
            return ExpenseCategoryNotFound(
              onCreateCategory: () {
                Navigator.pushNamed(context, CategoryList.name);
              },
            );
          }
        },
      ),
      floatingActionButton: FutureBuilder<List<CategoryModel>>(
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else if (snapshot.hasError) {
            return Container();
          } else if (snapshot.hasData) {
            final categories = snapshot.data!;
            return categories.isEmpty
                ? Container()
                : FloatingActionButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (_) => ExpenseForm(),
                      );
                    },
                    child: const Icon(Icons.add),
                  );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
