import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:progetto/screens/widgets/bar_model.dart';

class BarChart extends StatelessWidget {
  BarChart({Key? key}) : super(key: key);
  final Color customColor = Color.fromARGB(255, 113, 21, 163);

  List<charts.Series<BarMmodel, String>> _createSampleData() {
    final data = [
      // qui bisogna mettere i dati veri
      BarMmodel("MON", 20),
      BarMmodel("TUE", 23),
      BarMmodel("WED", 29),
      BarMmodel("THU", 30),
      BarMmodel("FRI", 29),
      BarMmodel("SAT", 23),
      BarMmodel("SUN", 20),
    ];
    return [
      charts.Series<BarMmodel, String>(
        data: data,
        id: 'sales',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(customColor),
        domainFn: (BarMmodel barModeel, _) => barModeel.day,
        measureFn: (BarMmodel barModeel, _) => barModeel.value,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 350,
      child: charts.BarChart(
        _createSampleData(),
        animate: true,
      ),
    );
  }
}
