import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
          entries:
              item['entries'] ?? 0, // Defina um valor padrão de 0 se for nulo
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
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final categories = snapshot.data!;

          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).hoverColor, // Cor adaptativa de fundo
              borderRadius:
                  BorderRadius.circular(10.0), // Bordas levemente arredondadas
            ),
            padding: EdgeInsets.all(12.0), // Espaçamento interno
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Despesas',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navegar para a página de todas as despesas
                      },
                      child: Text(
                        'Ver tudo',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    final category = categories[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(61, 189, 189, 189),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      padding: EdgeInsets.all(2.0),
                      child: ListTile(
                        leading: Icon(category.icon),
                        title: Text(category.title),
                        subtitle: Text('Entries: ${category.entries}'),
                        trailing: Text(
                            'R\$ ${category.totalAmount.toStringAsFixed(2)}'),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return Center(child: Text('No categories found'));
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
