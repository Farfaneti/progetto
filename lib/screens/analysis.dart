import 'package:flutter/material.dart';
import 'package:progetto/methods/theme.dart';
import 'package:progetto/screens/pressure_list.dart';
import 'package:progetto/screens/widgets/body_measurement_view.dart';
import 'package:progetto/screens/widgets/pressure_bar_chart.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../models/entities/pressure_records.dart';
import '../provider/homeprovider.dart';

class PressurePage extends StatefulWidget {
  const PressurePage({Key? key}) : super(key: key);

  static const routename = 'PressurePage';

  @override
  State<PressurePage> createState() => _PressurePageState();
}

class _PressurePageState extends State<PressurePage> {
  DateTime today = DateTime.now();
  late TextEditingController controller;
  

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PressureListPage(selectedDate: day),
    ));
  }

   Future<List<charts.Series<PressureValues, String>>> _createPressureData(HomeProvider homeProvider) async {
    List<PressureValues> systolicBP = [];
    List<PressureValues> diastolicBP = [];
     

    for (int i = 0; i < 7; i++) {
      DateTime currentDate = DateTime.now().subtract(Duration(days: i));
      double systolicAverage = await homeProvider.calculateDailySystolicPressureAverage(currentDate);
      double diastolicAverage = await homeProvider.calculateDailyDiastolicPressureAverage(currentDate);
      
      systolicBP.add(PressureValues(_getDayName(currentDate.weekday), systolicAverage));
      diastolicBP.add(PressureValues(_getDayName(currentDate.weekday), diastolicAverage));

    }

      systolicBP = systolicBP.reversed.toList();
      diastolicBP = diastolicBP.reversed.toList();

    Color customColor = Color.fromARGB(255, 113, 21, 163);
    Color customColor2 = Color.fromARGB(255, 208, 148, 241);

    return [
      charts.Series<PressureValues, String>(
        id: 'Systolic BP',
        domainFn: (PressureValues values, _) => values.day,
        measureFn: (PressureValues values, _) => values.pressure,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(customColor),
        data: systolicBP,
      ),
      charts.Series<PressureValues, String>(
        id: 'Diastolic BP',
        domainFn: (PressureValues values, _) => values.day,
        measureFn: (PressureValues values, _) => values.pressure,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(customColor2),
        data: diastolicBP,
      ),
    ];
  }

  static String _getDayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
              return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }

  


  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    print('${PressurePage.routename} built');
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
                'Values of Blood Pressure',
                textAlign: TextAlign.left,
                style: FitnessAppTheme.title,
              ),
            ),
            // va messo il grafico 1
            FutureBuilder<List<charts.Series<PressureValues, String>>>(
              future: _createPressureData(homeProvider),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show a loading indicator while data is being fetched
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}'); // Show an error message if fetching data fails
                } else {
                  final chartSeriesList = snapshot.data;

                  // Use the chartSeriesList to build the chart
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                     width: 350,
                     height: 200,
                      child: GroupedBarChart(
                        animate: true, // Provide the appropriate value for animate
                        seriesList: chartSeriesList ?? [], // Use the obtained chartSeriesList
                      ),
                    ),
                 
                  );
                }
              },
            ),

      

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(child: const BodyMeasurementView()),
            )
            // scommentare questo se si vuole mettere un widget con dentro valori medi
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const PressureRecordPage()));
        },
        backgroundColor: FitnessAppTheme.purple,
        child: const Icon(Icons.add),
      ),
    );
  }

}
class PressureValues {
  final String day;
  final double pressure;

  PressureValues(this.day, this.pressure);
}