class CategoryModel {
  int? categoryID;
  String categoryName;
  String? categoryDescription;
  int? entries;
  double? totalAmount;
  int? icon;

  CategoryModel({
    this.categoryID,
    required this.categoryName,
    this.categoryDescription,
    this.entries,
    this.totalAmount,
    this.icon,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryID: json['categoryID'] as int?,
      categoryName: json['title'] as String,
      categoryDescription: json['description'] as String?,
      entries: json['entries'] as int?,
      totalAmount: json['totalAmount'] != null
          ? (json['totalAmount'] as num).toDouble()
          : null,
      icon: json['icon'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'title': categoryName,
    };

    if (categoryID != null) {
      data['categoryID'] = categoryID;
    }
    if (categoryDescription != null) {
      data['description'] = categoryDescription;
    }
    if (entries != null) {
      data['entries'] = entries;
    }
    if (totalAmount != null) {
      data['totalAmount'] = totalAmount;
    }
    if (icon != null) {
      data['icon'] = icon;
    }

    return data;
  }
}
