import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../models/category_model.dart';

class CategoryDataSource {
  final String _baseUrl = 'http://10.0.2.2/api/category';

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final bodyBytes = response.bodyBytes;
        final bodyString = utf8.decode(bodyBytes);

        final data = json.decode(bodyString) as List<dynamic>;

        final List<CategoryModel> categories = data.map((item) {
          return CategoryModel(
            categoryID: item['categoryID'] as int?,
            categoryName: item['title'] as String,
            categoryDescription: item['description'] as String?,
            entries: item['entries'] as int?,
            totalAmount: item['totalAmount'] != null
                ? item['totalAmount'].toDouble()
                : null,
            icon: item['icon'] as int?,
          );
        }).toList();

        return categories;
      } else {
        print(
            'Failed to fetch categories. Status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Failed to fetch categories: $error');
      return [];
    }
  }

  Future<CategoryModel> addCategory(CategoryModel category) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(category.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = json.decode(response.body);
        final newCategory = CategoryModel.fromJson(responseBody);
        return newCategory;
      } else {
        print('Failed to add category. Status code: ${response.statusCode}');
        throw 'Failed to add category. Status code: ${response.statusCode}';
      }
    } catch (error) {
      print('Failed to add category: $error');
      throw 'Failed to add category: $error';
    }
  }

  Future<CategoryModel> updateCategory(
      CategoryModel oldCategory, CategoryModel newCategory) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/${oldCategory.categoryID}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(newCategory.toJson()),
      );

      if (response.statusCode == 200) {
        final updatedCategory =
            CategoryModel.fromJson(json.decode(response.body));
        return updatedCategory;
      } else {
        print('Failed to update category. Status code: ${response.statusCode}');
        throw 'Failed to update category. Status code: ${response.statusCode}';
      }
    } catch (error) {
      print('Failed to update category: $error');
      throw 'Failed to update category: $error';
    }
  }

  Future<void> deleteCategory(CategoryModel category) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/${category.categoryID}'),
      );

      if (response.statusCode != 200) {
        print('Failed to delete category. Status code: ${response.statusCode}');
        throw 'Failed to delete category. Status code: ${response.statusCode}';
      }
    } catch (error) {
      print('Failed to delete category: $error');
      throw 'Failed to delete category: $error';
    }
  }
}
