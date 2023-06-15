import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../screens/expenses/expense_list_screen.dart';

class ExpenseCategoryList extends StatefulWidget {
  @override
  _ExpenseCategoryListState createState() => _ExpenseCategoryListState();
}

class _ExpenseCategoryListState extends State<ExpenseCategoryList> {
  late Future<List<CategoryItem>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = _fetchCategories();
  }

  Future<List<CategoryItem>> _fetchCategories() async {
    final response = await http.get(Uri.parse('http://10.0.2.2/api/category'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      final List<CategoryItem> categories = data.map((item) {
        return CategoryItem(
          icon: IconData(item['icon'], fontFamily: 'MaterialIcons'),
          title: item['title'],
          entries: item['entries'] ?? 0,
          totalAmount: item['totalAmount'].toDouble(),
        );
      }).toList();

      return categories;
    } else {
      throw Exception(
          'Failed to fetch categories. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryItem>>(
      future: _categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final categories = snapshot.data!;

          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).hoverColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Categorias',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ExpenseListScreen(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.lightBlue[100],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 6.0,
                        ),
                        child: const Text(
                          'Ver despesas',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      final category = categories[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(61, 189, 189, 189),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        padding: const EdgeInsets.all(2.0),
                        child: ListTile(
                          leading: Icon(category.icon),
                          title: Text(category.title),
                          subtitle: Text('Despesas: ${category.entries}'),
                          trailing: Text(
                            'R\$ ${category.totalAmount.toStringAsFixed(2)}',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('No categories found'));
        }
      },
    );
  }
}

class CategoryItem {
  final IconData icon;
  final String title;
  final int entries;
  final double totalAmount;

  CategoryItem({
    required this.icon,
    required this.title,
    required this.entries,
    required this.totalAmount,
  });
}
