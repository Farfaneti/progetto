import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../analysis.dart';


class GroupedBarChart extends StatelessWidget {
  final List<charts.Series<PressureValues, String>> seriesList;
  final bool animate;

  const GroupedBarChart({
    Key? key,
    required this.seriesList,
    required this.animate,
  }) : super(key: key);

    @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
      behaviors: [charts.SeriesLegend()],
    );
  }
}
    






  