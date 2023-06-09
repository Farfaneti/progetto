import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progetto/methods/theme.dart';



import '../models/db.dart';
import '../models/entities/exercise.dart';



class ExerciseListPage extends StatefulWidget {
  final DateTime selectedDate;


  const ExerciseListPage({Key? key, required this.selectedDate}) : super(key: key);


  @override
  _ExerciseListPageState createState() => _ExerciseListPageState();
}


class _ExerciseListPageState extends State<ExerciseListPage> {
  late DateTime startTime;
  late DateTime endTime;
  List<Ex> exerciseList = [];
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
    final exerciseDao = database.exerciseDao;


    final exercise = await exerciseDao.findExercisebyDate(startTime, endTime);
    setState(() {
      exerciseList = exercise;
       isEmpty = exercise.isEmpty;
    });
  }


  void deleteExercise(Ex exercise) async {
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final exerciseDao = database.exerciseDao;


    await exerciseDao.deleteExercise(exercise);
    setState(() {
      exerciseList.remove(exercise);
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
        ? Center(
            child: Text('There is no data saved for this date'),
          )
        : ListView.builder(
            itemCount: exerciseList.length,
            itemBuilder: (context, index) {
              final exercise = exerciseList[index];
              return Card(
                child: ListTile(
                  title: Text(
                    'Activity: ${exercise.activityName}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Duration (min): ${exercise.duration}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Calories (Kcal): ${exercise.calories}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Date: ${exercise.dateTime}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => deleteExercise(exercise),
                  ),
                ),
              );
            },
          ),
  );
}
}