import 'package:flutter/material.dart';
import 'package:progetto/screens/pressure_day_list.dart';
import 'package:progetto/screens/pressure_records.dart';
import 'package:table_calendar/table_calendar.dart';

import '../methods/theme.dart';

class PressurePage extends StatefulWidget {
  PressurePage({Key? key}) : super(key: key);

  static const routename = 'PressurePage';

  @override
  State<PressurePage> createState() => _PressurePageState();
}

class _PressurePageState extends State<PressurePage> {
  DateTime today = DateTime.now();


  void _onDaySelected(DateTime day, DateTime focusedDay) {
  setState(() {
    today = day;
  });

  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => PressureListPage(selectedDate: day),
  ));
}

  @override
  Widget build(BuildContext context) {
    print('${PressurePage.routename} built');
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
            lastDay: DateTime.now(),
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // final pressure = await openDialog();
          // if (pressure == null) return;
          // setState(() => this.pressure = pressure);
          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const PressureRecordPage()
                                  ));
        },
        backgroundColor: FitnessAppTheme.purple,
        child: const Icon(Icons.add),
      ),
    );
  }

}
