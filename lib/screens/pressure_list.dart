
import 'package:flutter/material.dart';
import 'package:progetto/methods/theme.dart';
import 'package:progetto/screens/homepage.dart';

import '../models/db.dart';
import '../models/entities/pressure.dart';

class PressureListPage extends StatefulWidget {
  final DateTime selectedDate;

  const PressureListPage({Key? key, required this.selectedDate})
      : super(key: key);

  @override
  PressureListPageState createState() => PressureListPageState();
}

class PressureListPageState extends State<PressureListPage> {
  late DateTime startTime;
  late DateTime endTime;
  List<Pressure> pressureList = [];
  bool isEmpty = false;

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
      isEmpty = pressures.isEmpty;
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(
                  title: 'Home',
                  initialIndex: 1,
                ),
              ),
            );
          },
        ),
        title: const Text('Pressure Records'),
        backgroundColor: FitnessAppTheme.purple,
      ),
      body: isEmpty
          ? const Center(
              child: Text('There is no data saved for this date'),
            )
          : ListView.builder(
              itemCount: pressureList.length,
              itemBuilder: (context, index) {
                final pressure = pressureList[index];
                return Card(
                  color: FitnessAppTheme
                      .background, 
                  child: ListTile(
                    title: const Text(
                      'Blood Pressure:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: FitnessAppTheme
                            .grey, 
                      ),
                    ),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Systolic: ${pressure.systolic} mmHg',
                            style: const TextStyle(
                              fontSize: 16,
                              color: FitnessAppTheme
                                  .grey,
                            ),
                          ),
                          Text(
                            'Diastolic: ${pressure.diastolic} mmHg',
                            style: const TextStyle(
                              fontSize: 16,
                              color: FitnessAppTheme
                                  .grey, 
                            ),
                          ),
                          Text(
                            'Date: ${pressure.dateTime}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: FitnessAppTheme
                                  .nearlyBlue,
                            ),
                          ),
                        ]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => deletePressure(pressure),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
