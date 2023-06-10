import 'package:flutter/material.dart';
import 'package:progetto/provider/homeprovider.dart';
import 'package:progetto/screens/exercise_list.dart';
import 'package:progetto/screens/widgets/Met_bar_chart.dart';

import 'package:progetto/screens/widgets/met_status.dart';
import 'package:progetto/screens/widgets/percentage_indicator.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../methods/theme.dart';
import '../methods/title_view.dart';
import '../utils/shared_preferences.dart';

class GraphPage extends StatefulWidget {
  GraphPage({Key? key}) : super(key: key);

  static const routename = 'GraphPage';

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  DateTime today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });

      Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ExerciseListPage(selectedDate: day),
    ));
  }
 final Color customColor = Color.fromARGB(255, 113, 21, 163);

   Future<List<charts.Series<BarMmodel, String>>> _createSampleData(HomeProvider homeProvider) async{
   
   final pref = Provider.of<Preferences>(context);
   print('weight=${pref.weight}');
   Map<String, double> datas = await homeProvider.METforWeek(DateTime.now(), pref.weight ?? 0);
   print('${datas.entries}');
    
    List<BarMmodel> data= datas.entries.map((entry) {
            return BarMmodel(entry.key, entry.value);
          }).toList();
    print('data= ${data.length}');
    return [
      charts.Series<BarMmodel, String>(
        data: data,
        id: 'Met-min',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(customColor),
        domainFn: (BarMmodel barModeel, _) => barModeel.day,
        measureFn: (BarMmodel barModeel, _) => barModeel.value,
        
      )
    ];
    
  }


  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    print('${GraphPage.routename} built');
    return Scaffold(
      backgroundColor: FitnessAppTheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              locale: "en_US",
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false, titleCentered: true),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime(2030, 10, 16),
              onDaySelected: _onDaySelected,
              calendarFormat: CalendarFormat.week,
            ),

            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'MET-min weekly percentage',
                textAlign: TextAlign.left,
                style: FitnessAppTheme.title,
              ),
            ),
            // va messo il grafico 2
            const Padding(
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 20.0),
              child: SizedBox(
                     width: 350,
                     height: 200,
              child: PercentageIndicator(),
              )
            ),
            METStatusBox(),

            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Weekly MET levels',
                textAlign: TextAlign.left,
                style: FitnessAppTheme.title,
              ),
            ),
            // va messo il grafico 1
            FutureBuilder<List<charts.Series<BarMmodel, String>>>(
              future: _createSampleData(homeProvider),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show a loading indicator while data is being fetched
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}'); // Show an error message if fetching data fails
                } else {
                  final chartMetModel = snapshot.data;

                  // Use the chartSeriesList to build the chart
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                     width: 350,
                     height: 200,
                      child: METBarChart( // Provide the appropriate value for animate
                        metmodel: chartMetModel ?? [], // Use the obtained chartSeriesList
                      ),
                    ),
                 
                  );
                }
              },
            ),
            //
          ],
        ),
      ),
    );
  }
}

class BarMmodel {
  final String day;
  final double value;
  BarMmodel(this.day, this.value);
}
