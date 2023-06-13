import 'package:budget_tracker/models/category_model.dart';

class ExpenseModel {
  int? expenseID;
  String? title;
  String? description;
  double? amount;
  DateTime date;
  CategoryModel? category;

  ExpenseModel({
    this.expenseID,
    this.title,
    this.description,
    required this.amount,
    required this.date,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'expenseID': expenseID,
      'title': title,
      'description': description,
      'amount': amount!.toDouble(),
      'date': date.toIso8601String(),
      'category': category?.toJson(), // Serializar o objeto da categoria
    };
  }

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      expenseID: json['expenseID'],
      title: json['title'],
      description: json['description'],
      amount: json['amount'].toDouble(),
      date: DateTime.parse(json['date']),
      category: CategoryModel.fromJson(json['category']
          as Map<String, dynamic>), // Desserializar o objeto da categoria
    );
  }
}
