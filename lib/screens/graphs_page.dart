import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progetto/methods/theme.dart';
import 'package:progetto/provider/homeprovider.dart';
import 'package:progetto/screens/exercise_list.dart';
import 'package:progetto/screens/widgets/bar_chart.dart';

import 'package:progetto/screens/widgets/met_status.dart';
import 'package:progetto/screens/widgets/percentage_indicator.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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


String getStartOfTheWeek(DateTime date) {
    DateTime startOfTheWeek = date.subtract(Duration(days: date.weekday - 1));
    return DateFormat('MMMM d').format(startOfTheWeek);
  }

  String getEndOfTheWeek(DateTime date) {
    DateTime endOfTheWeek = date.add(Duration(days: DateTime.daysPerWeek - date.weekday));
    return DateFormat('MMMM d').format(endOfTheWeek);
  }
  
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    print('${GraphPage.routename} built');
    return Scaffold(
        backgroundColor: FitnessAppTheme.background,
        body: SingleChildScrollView(
            child: Column(children: [
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
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '${getStartOfTheWeek(DateTime.now())} - ${getEndOfTheWeek(DateTime.now())}', // Aggiunta della settimana corrente
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: FitnessAppTheme.lightPurple
                ),
              ),
            ),
          // va messo il grafico 2
          const Padding(
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 20.0),
              child: SizedBox(
                width: 350,
                height: 200,
                child: PercentageIndicator(),
              )),
          METStatusBox(),

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Weekly MET-min levels',
              textAlign: TextAlign.left,
              style: FitnessAppTheme.title,
            ),
          ),
          // va messo il grafico 1

          // Use the chartSeriesList to build the chart
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 350,
              height: 200,
              child: BarChart(),
            ),
          )
        ])));
  }
}
