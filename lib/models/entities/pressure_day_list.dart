import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progetto/models/entities/pressure.dart';

import '../db.dart';

class PressureListPage extends StatefulWidget {
  final DateTime selectedDate;

  const PressureListPage({Key? key, required this.selectedDate})
      : super(key: key);

  @override
  _PressureListPageState createState() => _PressureListPageState();
}

class _PressureListPageState extends State<PressureListPage> {
  late DateTime startTime;
  late DateTime endTime;
  List<Pressure> pressureList = [];

  @override
  void initState() {
    super.initState();
    startTime = DateTime(widget.selectedDate.year, widget.selectedDate.month,
        widget.selectedDate.day);
    endTime = startTime.add(Duration(days: 1));

    fetchPressureData();
  }

  void fetchPressureData() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final pressureDao = database.pressureDao;

    final pressures = await pressureDao.findPressurebyDate(startTime, endTime);
    setState(() {
      pressureList = pressures;
    });
  }

  void deletePressure(Pressure pressure) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final pressureDao = database.pressureDao;

    await pressureDao.deletePressure(pressure);
    setState(() {
      pressureList.remove(pressure);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pressure Records'),
      ),
      body: ListView.builder(
        itemCount: pressureList.length,
        itemBuilder: (context, index) {
          final pressure = pressureList[index];
          return ListTile(
            title: Text(
                'Systolic: ${pressure.systolic}, Diastolic: ${pressure.diastolic}'),
            subtitle: Text('Time: ${pressure.dateTime}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => deletePressure(pressure),
            ),
          );
        },
      ),
    );
  }
}
