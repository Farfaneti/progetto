import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../graphs_page.dart';



class METBarChart extends StatelessWidget {

    final List<charts.Series<BarMmodel, String>> metmodel;
    
    METBarChart({
    Key? key,
    required this.metmodel,
    
  }) : super(key: key);

    @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      metmodel,
      animate: true,
      barGroupingType: charts.BarGroupingType.grouped,
      behaviors: [charts.SeriesLegend()],
    );
  }
}