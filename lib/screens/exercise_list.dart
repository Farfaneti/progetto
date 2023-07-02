import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progetto/methods/theme.dart';
import 'package:progetto/models/entities/met.dart';



import '../models/db.dart';
import '../models/entities/exercise.dart';



class ExerciseListPage extends StatefulWidget {
  final DateTime selectedDate;


  const ExerciseListPage({Key? key, required this.selectedDate}) : super(key: key);


  @override
  ExerciseListPageState createState() => ExerciseListPageState();
}


class ExerciseListPageState extends State<ExerciseListPage> {
  late DateTime startTime;
  late DateTime endTime;
  List<Ex> exerciseList = [];
  List<MET> metList = [];
  bool isEmpty = false;

  @override
  void initState() {
    super.initState();
    startTime = DateTime(widget.selectedDate.year, widget.selectedDate.month, widget.selectedDate.day);
    endTime = startTime.add(Duration(days: 1));

    fetchExerciseData();
  }


  void fetchExerciseData() async {
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  
    final metData= await database.metDao.findMetbyDate(startTime, endTime);


    final exercise = await database.exerciseDao.findExercisebyDate(startTime, endTime);
    setState(() {
      exerciseList = exercise;
       isEmpty = exercise.isEmpty;
       metList=metData;
    });
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Exercise Records'),
      backgroundColor: FitnessAppTheme.purple,
    ),
    body: isEmpty
        ? const Center(
            child: Text('There is no data saved for this date'),
          )
        : ListView.builder(
            itemCount: exerciseList.length,
            itemBuilder: (context, index) {
              final exercise = exerciseList[index];
              final met= metList[index];
              final metmin = double.parse(met.met.toStringAsFixed(2));
              return Card(
                child: ListTile(
                  title: Text(
                    'Activity: ${exercise.activityName}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Duration (min): ${exercise.duration}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Calories (Kcal): ${exercise.calories}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'MET-min: $metmin',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Date: ${exercise.dateTime}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
  );
}
}