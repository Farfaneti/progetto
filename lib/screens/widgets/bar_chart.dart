import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

import '../../provider/homeprovider.dart';
import '../../utils/shared_preferences.dart';


class BarChart extends StatelessWidget {
  BarChart({Key? key}) : super(key: key);
  final Color customColor = Color.fromARGB(255, 113, 21, 163);

  List<charts.Series<BarMmodel, String>> _createSampleData(List<BarMmodel> data) {
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
    final pref = Provider.of<Preferences>(context);
    final homeProvider = Provider.of<HomeProvider>(context);

    return  FutureBuilder<Map<String, double>>(
      future: homeProvider.METforWeek(DateTime.now(), pref.weight ?? 0), 
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!.entries.map((entry) {
            return BarMmodel(entry.key, entry.value);
          }).toList();
    
       return SizedBox(
            height: 300,
            width: 350,
            child: charts.BarChart(
              _createSampleData(data),
              animate: true,
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
      );
   
}
}
class BarMmodel {
  final String day;
  final double value;
  BarMmodel(this.day, this.value);
}
