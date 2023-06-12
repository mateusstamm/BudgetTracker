import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExpenseCategoryList extends StatefulWidget {
  @override
  _ExpenseCategoryListState createState() => _ExpenseCategoryListState();
}

class _ExpenseCategoryListState extends State<ExpenseCategoryList> {
  List<CategoryItem> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2/api/category'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<CategoryItem> fetchedCategories =
            data.map<CategoryItem>((item) {
          return CategoryItem(
            icon: IconData(item['icon'], fontFamily: 'MaterialIcons'),
            title: item['title'],
            entries: item['entries'],
            totalAmount: item['totalAmount'].toDouble(),
          );
        }).toList();
        setState(() {
          categories = fetchedCategories;
        });
      } else {
        print('Failed to fetch categories: ${response.statusCode}');
      }
    } catch (error) {
      print('Failed to fetch categories: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return ListTile(
          leading: Icon(category.icon),
          title: Text(category.title),
          subtitle: Text('Entries: ${category.entries}'),
          trailing: Text('R\$ ${category.totalAmount.toStringAsFixed(2)}'),
        );
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
