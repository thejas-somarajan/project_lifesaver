import 'package:charts_flutter/flutter.dart' as charts;

class BarChartModel {
  String month;
  int rate;
  final charts.Color color;

  BarChartModel({
    required this.month,
    required this.rate,
    required this.color,
  });
}