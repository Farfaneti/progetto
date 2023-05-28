import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GroupedBarChart extends StatelessWidget {
  final List<charts.Series<PressureValues, String>> seriesList;
  final bool animate;

  GroupedBarChart(this.seriesList, {Key? key, required this.animate});

  factory GroupedBarChart.withSampleData() {
    return GroupedBarChart(
      _createSampleData(),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
      behaviors: [charts.SeriesLegend()],
    );
  }

  static List<charts.Series<PressureValues, String>> _createSampleData() {
    final systolicBP = [
      PressureValues('MON', 5),
      PressureValues('TUE', 25),
      PressureValues('WED', 100),
      PressureValues('THU', 75),
      PressureValues('FRI', 75),
      PressureValues('SAT', 75),
      PressureValues('SUN', 75),
    ];

    final diastolicBP = [
      PressureValues('MON', 25),
      PressureValues('TUE', 50),
      PressureValues('WED', 10),
      PressureValues('THU', 20),
      PressureValues('FRI', 75),
      PressureValues('SAT', 75),
      PressureValues('SUN', 75),
    ];

    Color customColor = Color.fromARGB(255, 113, 21, 163);
    final Color customColor2 = Color.fromARGB(255, 208, 148, 241);
    return [
      charts.Series<PressureValues, String>(
        id: 'Systolic BP',
        domainFn: (PressureValues sales, _) => sales.year,
        measureFn: (PressureValues sales, _) => sales.sales,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(
            customColor), // Colore personalizzato per la serie 'Systolic BP'
        data: systolicBP,
      ),
      charts.Series<PressureValues, String>(
        id: 'Diastolic BP',
        domainFn: (PressureValues sales, _) => sales.year,
        measureFn: (PressureValues sales, _) => sales.sales,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(customColor2),
        data: diastolicBP,
      ),
    ];
  }
}

class PressureValues {
  final String year;
  final int sales;

  PressureValues(this.year, this.sales);
}
