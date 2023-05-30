import 'dart:math';

import 'package:flutter/material.dart';
import 'package:progetto/models/db.dart';
import 'package:progetto/screens/entities.dart';
import 'package:progetto/services/server_string.dart';
import 'package:progetto/utils/shared_preferences.dart';

import '../screens/pressure_dao.dart';
import '../services/impact.dart';

// this is the change notifier. it will manage all the logic of the home page: fetching the correct data from the database
// and on startup fetching the data from the online services
class HomeProvider extends ChangeNotifier {
  // data to be used by the UI
  late List<Ex> exercises;
  late List<Pressure> pressure;
  final AppDatabase db;

  // data fetched from external services or db
  late List<Ex> _exercisesDB;
  late List<Pressure> _pressure;

  // selected day of data to be shown
  DateTime showDate = DateTime.now().subtract(const Duration(days: 1));

  DateTime lastFetch = DateTime.now().subtract(Duration(days: 2));
  final ImpactService impactService;

  bool doneInit = false;

  HomeProvider(this.impactService, this.db) {
    _init();
  }

  // constructor of provider which manages the fetching of all data from the servers and then notifies the ui to build
  Future<void> _init() async {
    await _fetchAndCalculate();
    getDataOfDay(showDate);
    doneInit = true;
    notifyListeners();
  }

  // method to fetch all data and calculate the exposure
  Future<void> _fetchAndCalculate() async {
    _exercisesDB = await impactService.getDataFromDay(lastFetch);
    for (var element in _exercisesDB) {
      db.exerciseDao.insertExercise(element);
    } // db add to the table
  }

  // method to trigger a new data fetching
  void refresh() {
    _fetchAndCalculate();
    getDataOfDay(showDate);
  }

  // method to select only the data of the chosen day
  Future<void> getDataOfDay(DateTime showDate) async {
    this.showDate = showDate;
    exercises = await db.exerciseDao.findExercisebyDate(
        DateUtils.dateOnly(showDate),
        DateTime(showDate.year, showDate.month, showDate.day, 23, 59));

    // after selecting all data we notify all consumers to rebuild
    notifyListeners();
  }    
   



//metod to calculate the Met min value of ONE DAY
  double calculateMETforDay(DateTime date, int weight) {
    double totalMET = 0;

    for (var exercise in exercises) {
      if (exercise.dateTime.year == date.year &&
          exercise.dateTime.month == date.month &&
          exercise.dateTime.day == date.day) {
        double durationInHours =
            exercise.duration / 60; // Convert duration from minutes to hours   DA CONTROLLARE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        double met = exercise.calories / (weight / durationInHours) / 3.5;
        totalMET += met;
      }
    }

    return totalMET;
  }

//restituisce la data corrispondente al lunedì della stessa settimana  
DateTime getStartOfWeek(DateTime date) {
  int difference = date.weekday - DateTime.monday;
  if (difference < 0) {
    difference += 7;
  }
  return date.subtract(Duration(days: difference));
}

// calcolo del MET come somma dei Met di una settimana, usa il metodo sopra per trovare il lunedì della settimana attuale
  double calculateMETforWeek(DateTime date, int weight) {
    DateTime startDate = getStartOfWeek(date);
    Map<String, double> weeklyMET = {};
    DateTime currentDate = startDate;
    double weekMETmin = 0;

    for (int i = 0; i < 7; i++) {
      double totalMET = 0;

      for (var exercise in exercises) {
        if (exercise.dateTime.year == currentDate.year &&
            exercise.dateTime.month == currentDate.month &&
            exercise.dateTime.day == currentDate.day) {
          double durationInHours =
              exercise.duration / 60; // Convert duration from minutes to hours
          double met = exercise.calories / (weight / durationInHours) / 3.5;
          totalMET += met; //mantiene il valore del met del singolo giorno 
          weekMETmin += met; // salva il valore del met dell'intera settimana
        }
      }

      String dayName = _getDayName(currentDate.weekday);
      weeklyMET[dayName] = totalMET;

      currentDate = currentDate.add(Duration(days: 1));
    }

    return weekMETmin; //così ritorno solo il valore di MET raggiunto fino a quel giorno della settimana
    //return weeklyMET //mi torna per ogni giorno della settimana quel è stato il valore di met raggiunto
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }


// Function to calculate the daily average of pressure data for a specific day
Future<double> calculateDailySystolicPressureAverage(
    DateTime specificDay, PressureDao pressureDao) async {
  // Get the start and end time of the specific day
  DateTime startTime = DateTime(specificDay.year, specificDay.month, specificDay.day);
  DateTime endTime = DateTime(specificDay.year, specificDay.month, specificDay.day, 23, 59, 59);

  // Retrieve the pressure data for the specific day
  List<Pressure> pressureList =
      await pressureDao.findPressurebyDate(startTime, endTime);

  // Calculate the sum of systolic pressure values
  int systolicSum = 0;
  

  for (Pressure pressure in pressureList) {
    systolicSum += pressure.systolic;
    
  }

  // Calculate the average values
  double systolicAverage = systolicSum / pressureList.length;

  return systolicAverage;

}

Future<double> calculateDailyDiastolicPressureAverage(
  DateTime specificDay, PressureDao pressureDao) async {
  // Get the start and end time of the specific day
  DateTime startTime = DateTime(specificDay.year, specificDay.month, specificDay.day);
  DateTime endTime = DateTime(specificDay.year, specificDay.month, specificDay.day, 23, 59, 59);

  // Retrieve the pressure data for the specific day
  List<Pressure> pressureList =
      await pressureDao.findPressurebyDate(startTime, endTime);

  // Calculate the sum of  diastolic pressure values
  int diastolicSum = 0;
  

  for (Pressure pressure in pressureList) {
    diastolicSum += pressure.diastolic;
    
  }

  // Calculate the average values
  double diastolicAverage = diastolicSum / pressureList.length;

  return diastolicAverage;
}


}
