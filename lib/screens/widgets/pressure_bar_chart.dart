import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../models/daos/pressure_dao.dart';
import '../../models/entities/pressure.dart';
import '../../provider/homeprovider.dart';
import '../analysis.dart';


class GroupedBarChart extends StatelessWidget {
  final List<charts.Series<PressureValues, String>> seriesList;
  final bool animate;

  GroupedBarChart({
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
    






  