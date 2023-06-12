class ExpenseModel {
  int? expenseID;
  String? title;
  String? description;
  double amount;
  DateTime date;
  int? categoryID;

  ExpenseModel({
    this.expenseID,
    this.title,
    this.description,
    required this.amount,
    required this.date,
    this.categoryID,
  });

  Map<String, dynamic> toJson() {
    return {
      'expenseID': expenseID,
      'title': title,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
      'categoryID': categoryID,
    };
  }

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      expenseID: json['expenseID'],
      title: json['title'],
      description: json['description'],
      amount: json['amount'].toDouble(),
      date: DateTime.parse(json['date']),
      categoryID: json['categoryID'],
    );
  }
}
