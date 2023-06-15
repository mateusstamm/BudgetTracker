import 'package:flutter/material.dart';
import '../../data/datasources/remote_api/category_data_source.dart';
import '../../data/datasources/remote_api/expense_data_source.dart';
import '../../models/category_model.dart';
import '../../widgets/category_screen/category_form.dart';
import '../../widgets/general/drawer_default.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);
  static const name = '/category_list';

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final CategoryDataSource _categoryDataSource = CategoryDataSource();
  final ExpenseDataSource _expenseDataSource = ExpenseDataSource();
  List<CategoryModel> _categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final categories = await _categoryDataSource.fetchCategories();
      setState(() {
        _categories = categories;
      });
    } catch (error) {
      //print('Failed to fetch categories: $error');
    }
  }

  Future<void> addCategory(CategoryModel category) async {
    try {
      final newCategory = await _categoryDataSource.addCategory(category);
      setState(() {
        _categories.add(newCategory);
      });
    } catch (error) {
      //print('Failed to add category: $error');
    }
  }

  Future<void> updateCategory(
      CategoryModel oldCategory, CategoryModel newCategory) async {
    try {
      final updatedCategory =
          await _categoryDataSource.updateCategory(oldCategory, newCategory);
      setState(() {
        final index = _categories.indexOf(oldCategory);
        _categories[index] = updatedCategory;
      });
    } catch (error) {
      //print('Failed to update category: $error');
    }
  }

  Future<void> deleteCategory(CategoryModel category) async {
    try {
      final hasExpenses = await _expenseDataSource.hasExpenses(category);
      if (hasExpenses) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Erro'),
              content: const Text(
                'Existem despesas cadastradas nesta categoria. Remova-as primeiro para prosseguir.',
              ),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => CategoryList()));
                  },
                ),
              ],
            );
          },
        );
        return;
      }

      await _categoryDataSource.deleteCategory(category);
      setState(() {
        _categories.remove(category);
      });
    } catch (error) {
      //print('Failed to delete category: $error');
    }
  }

  void _openEditForm(CategoryModel category) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CategoryForm(
          category: category,
          icon: category.icon != null
              ? IconData(category.icon!, fontFamily: 'MaterialIcons')
              : null,
          onSave: (editedCategory) async {
            await updateCategory(category, editedCategory);
            Navigator.pop(context);
            fetchCategories();
          },
          onCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _openAddForm() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CategoryForm(
          onSave: (newCategory) async {
            await addCategory(newCategory);
            Navigator.pop(context);
            fetchCategories();
          },
          onCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _navigateToCategoryScreen(CategoryModel category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Categorias',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const DrawerDefault(),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              return Dismissible(
                key: Key(category.categoryName),
                background: Container(
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                direction: DismissDirection.endToStart,
                confirmDismiss: (_) async {
                  return await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Confirmação'),
                        content: const Text(
                          'Tem certeza de que deseja excluir esta categoria?',
                        ),
                        actions: [
                          TextButton(
                            child: const Text('Não'),
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                          ),
                          TextButton(
                            child: const Text('Sim'),
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                onDismissed: (_) => deleteCategory(category),
                child: ListTile(
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(
                      category.icon != null
                          ? IconData(category.icon!,
                              fontFamily: 'MaterialIcons')
                          : Icons
                              .category, // Usar o ícone padrão caso o código seja nulo
                      color: Colors.white,
                    ),
                  ),
                  title: Text(category.categoryName),
                  subtitle: Text(category.categoryDescription!),
                  trailing: GestureDetector(
                    onTap: () => _openEditForm(category),
                    child: const Icon(Icons.create),
                  ),
                ),
              );
            },
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  'Deslize para deletar',
                  style: TextStyle(
                    color: Color.fromARGB(72, 185, 185, 185),
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _openAddForm();
        },
      ),
    );
  }
}
