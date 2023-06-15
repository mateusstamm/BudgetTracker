import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../data/datasources/remote_api/category_data_source.dart';
import '../../models/category_model.dart';

class ExpenseChart extends StatefulWidget {
  const ExpenseChart({Key? key});

  @override
  _ExpenseChartState createState() => _ExpenseChartState();
}

class _ExpenseChartState extends State<ExpenseChart> {
  late Future<List<CategoryModel>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = CategoryDataSource().fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryModel>>(
      future: _categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final categories = snapshot.data!;
          final data = _createData(categories);

          if (data.isEmpty) {
            return const Center(
                child: Text('Ainda não há despesas registradas.'));
          }

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 20), // Ajuste o valor conforme necessário
                child: SfCircularChart(
                  series: <CircularSeries>[
                    PieSeries<CategoryModel, String>(
                      dataSource: data,
                      xValueMapper: (CategoryModel category, _) =>
                          category.categoryName,
                      yValueMapper: (CategoryModel category, _) =>
                          category.totalAmount ?? 0,
                      dataLabelMapper: (CategoryModel category, _) =>
                          '${category.categoryName}\n        ${_calculatePercentage(category, categories).toStringAsFixed(1)}%',
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        color: Colors.black,
                        labelAlignment: ChartDataLabelAlignment.top,
                        labelPosition: ChartDataLabelPosition.outside,
                        useSeriesColor: true,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text(
                      'QUANTIA TOTAL POR CATEGORIA',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }

  List<CategoryModel> _createData(List<CategoryModel> categories) {
    return categories
        .where((category) =>
            category.totalAmount != null && category.totalAmount! > 0)
        .toList();
  }

  double _calculatePercentage(
      CategoryModel category, List<CategoryModel> categories) {
    double totalAmount = categories.fold(
        0.0, (double sum, CategoryModel c) => sum + (c.totalAmount ?? 0));
    return (category.totalAmount ?? 0) / totalAmount * 100;
  }
}
