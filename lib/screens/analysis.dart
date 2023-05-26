import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../methods/theme.dart';

class PressurePage extends StatefulWidget {
  PressurePage({Key? key}) : super(key: key);

  static const routename = 'GraphPage';

  @override
  State<PressurePage> createState() => _PressurePageState();
}

class _PressurePageState extends State<PressurePage> {
  DateTime today = DateTime.now();
  TextEditingController controller = TextEditingController();
  var pressure = 0;

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
          Text('Pressure values'),
          Text('$pressure'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final pressure = await openDialog();
          if (pressure == null) return;
        },
        backgroundColor: FitnessAppTheme.purple,
        child: const Icon(Icons.add),
      ),
    );
  }

  // Pop-up dialog method
  Future<int?> openDialog() => showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text(
              'Add blood pressure value',
              style: FitnessAppTheme.title,
            ),
            content: const TextField(
              //controller: controller,
              keyboardType: TextInputType.numberWithOptions(),
              autofocus: true,
              decoration: InputDecoration(
                  hintText: 'Pressure', hintStyle: FitnessAppTheme.body1),
            ),
            actions: [
              TextButton(
                onPressed: submit,
                child: const Text(
                  'Save',
                  style: FitnessAppTheme.button,
                ),
              )
            ],
          ));

  void submit() {
    Navigator.of(context).pop(controller.text);
    controller.clear();
  }
}
