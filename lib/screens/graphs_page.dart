import 'package:flutter/material.dart';
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
      body: Column(
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
              'Graph1',
              textAlign: TextAlign.left,
              style: FitnessAppTheme.title,
            ),
          ),
          // va messo il grafico 1
          //
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Graph2',
              textAlign: TextAlign.left,
              style: FitnessAppTheme.title,
            ),
          ),
          // va messo il grafico 2
        ],
      ),
    );
  }
}
