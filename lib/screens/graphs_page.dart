import 'package:flutter/material.dart';
import 'package:progetto/screens/widgets/bar_chart.dart';
import 'package:progetto/screens/widgets/percentage_indicator.dart';
import 'package:table_calendar/table_calendar.dart';

import '../methods/theme.dart';
import '../methods/title_view.dart';

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
  }

  @override
  Widget build(BuildContext context) {
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
                'MET daily percentage',
                textAlign: TextAlign.left,
                style: FitnessAppTheme.title,
              ),
            ),
            // va messo il grafico 2
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 20.0),
              child: const Percentage_Indicator(),
            ),

            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Weekly MET levels',
                textAlign: TextAlign.left,
                style: FitnessAppTheme.title,
              ),
            ),
            // va messo il grafico 1
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BarChart(),
            ),
            //
          ],
        ),
      ),
    );
  }
}
