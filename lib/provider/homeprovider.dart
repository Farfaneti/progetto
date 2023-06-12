import 'dart:math';

import 'package:flutter/material.dart';
import 'package:progetto/models/db.dart';
import 'package:progetto/models/entities/met.dart';
import '../models/entities/exercise.dart';
import '../models/entities/pressure.dart';
import '../services/impact.dart';

// this is the change notifier. it will manage all the logic of the home page: fetching the correct data from the database
// and on startup fetching the data from the online services
class HomeProvider extends ChangeNotifier {
  // data to be used by the UI
  late List<Ex> exercises;
  late List<Pressure> pressure;
   late List<MET> met;
  final AppDatabase db;

  // data fetched from external services or db
  late List<Ex> _exercisesDB;


  // selected day of data to be shown
  DateTime showDate = DateTime.now().subtract(const Duration(days: 1));

  final ImpactService impactService;
  late DateTime lastFetch;

  HomeProvider(this.impactService, this.db) {
    _init();
  }

  // constructor of provider which manages the fetching of all data from the servers and then notifies the ui to build
  Future<void> _init() async {
    await _fetch();
    notifyListeners();
  }

  Future<DateTime?> _getLastFetch() async {
    var data = await db.exerciseDao.findLastDayInDb();
    if (data == null) {
      return null;
    }
    return data.dateTime;
  }

  // method to fetch all data
  Future<void> _fetch() async {
    lastFetch = await _getLastFetch() ??
        DateTime.now().subtract(const Duration(days: 6));
    // do nothing if already fetched
    if (lastFetch.day == DateTime.now().subtract(const Duration(days: 1)).day) {
      return;
    }
    lastFetch = lastFetch.add(const Duration(
        days:
            1)); //aggiungo un giorno, perchè così risolvo il problema che c'è se per 1 giorno non si allena
    _exercisesDB = await impactService.getDataFromDay(lastFetch);
    if (_exercisesDB.isEmpty) {
      return;
    }
    for (var element in _exercisesDB) {
      db.exerciseDao.insertExercise(element);
    } // db add to the table
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
  Future<double> calculateMETforWeek(DateTime date, int weight) async {
    DateTime startDate = getStartOfWeek(date);
    Map<String, double> weeklyMET = {};
    DateTime currentDate = startDate;
    double weekMETmin = 0;
    double met_min = 0;
    double weekMETmin_perc = 0;

    List<Ex> exercises =
        await db.exerciseDao.findExercisebyDate(currentDate, date);
    if (exercises.isEmpty) {
      return 0;
    }

    for (int i = 0; i < 7; i++) {
      double totalMET = 0;

      for (var exercise in exercises) {
        if (exercise.dateTime.year == currentDate.year &&
            exercise.dateTime.month == currentDate.month &&
            exercise.dateTime.day == currentDate.day) {
          double durationInHours =
              exercise.duration / 60; // Convert duration from minutes to hours
          double met = exercise.calories / (weight * durationInHours);
          met_min = met * (exercise.duration);
          totalMET += met_min; //mantiene il valore del met del singolo giorno
          weekMETmin +=
              met_min; // salva il valore del met dell'intera settimana
        }
      }
      

      String dayName = _getDayName(currentDate.weekday);
      weeklyMET[dayName] = totalMET;

      currentDate = currentDate.add(Duration(days: 1));

      weekMETmin_perc = weekMETmin / 4000;
      if (weekMETmin_perc > 1) {
        weekMETmin_perc = 1;
      }
    }
    weekMETmin_perc = double.parse(weekMETmin_perc.toStringAsFixed(2));
    return weekMETmin_perc; //così ritorno solo il valore di MET raggiunto fino a quel giorno della settimana
    //return weeklyMET //mi torna per ogni giorno della settimana quel è stato il valore di met raggiunto
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  Future<Map<String, double>> METforWeek(DateTime date, int weight) async {
    DateTime startDate = getStartOfWeek(date);
    Map<String, double> weeklyMET = {};
    DateTime currentDate = startDate;

    List<Ex> exercises =
        await db.exerciseDao.findExercisebyDate(currentDate, date);

    for (int i = 0; i < 7; i++) {
      double totalMET = 0;

      for (var exercise in exercises) {
        if (exercise.dateTime.year == currentDate.year &&
            exercise.dateTime.month == currentDate.month &&
            exercise.dateTime.day == currentDate.day) {
          double durationInHours =
              exercise.duration / 60; // Convert duration from minutes to hours
          double met = exercise.calories / (weight * durationInHours);
          double met_min = met * (exercise.duration);          
          totalMET += met_min; //mantiene il valore del met del singolo giorno
          final metDB =MET(null, met_min , exercise.dateTime, exercise.id);
          insertMet(metDB);  // qui aggiungo il met-min relativo all'esercizio, nel db, onConflict.abort, cioè tiene solo la prima versione che viene inserita nel db
        }

        totalMET = double.parse(totalMET.toStringAsFixed(2));

        print('totmet=$totalMET');
        String dayName = _getDayName(currentDate.weekday);
        weeklyMET[dayName] = totalMET;
      }
      currentDate = currentDate.add(Duration(days: 1));
    }

    print('$weeklyMET');

    return weeklyMET; //così ritorno solo il valore di MET raggiunto fino a quel giorno della settimana
    //return weeklyMET //mi torna per ogni giorno della settimana quel è stato il valore di met raggiunto
  }

// Function to calculate the daily average of pressure data for a specific day
  Future<double> calculateDailySystolicPressureAverage(
      DateTime specificDay) async {
    // Get the start and end time of the specific day
    DateTime startTime =
        DateTime(specificDay.year, specificDay.month, specificDay.day);
    DateTime endTime = DateTime(
        specificDay.year, specificDay.month, specificDay.day, 23, 59, 59);

    // Retrieve the pressure data for the specific day
    List<Pressure> pressureList =
        await db.pressureDao.findPressurebyDate(startTime, endTime);

    if (pressureList.isEmpty) {
      return 0; // Return 0 if no data is available
    }

    // Calculate the sum of systolic pressure values
    int systolicSum = 0;

    for (Pressure pressure in pressureList) {
      systolicSum += pressure.systolic;
    }

    // Calculate the average values
    double systolicAverage = systolicSum / pressureList.length;

    return systolicAverage;
  }

  Future<int> calculateDailyMaxSystolicPressure(DateTime specificDay) async {
    // Get the start and end time of the specific day
    DateTime startTime =
        DateTime(specificDay.year, specificDay.month, specificDay.day);
    DateTime endTime = DateTime(
        specificDay.year, specificDay.month, specificDay.day, 23, 59, 59);

    // Retrieve the pressure data for the specific day
    List<Pressure> pressureList =
        await db.pressureDao.findPressurebyDate(startTime, endTime);

    if (pressureList.isEmpty) {
      return 0; // Return 0 if no data is available
    }

    // Find the maximum systolic pressure value
    int maxSystolic = pressureList[0].systolic;

    for (Pressure pressure in pressureList) {
      if (pressure.systolic > maxSystolic) {
        maxSystolic = pressure.systolic;
      }
    }

    return maxSystolic;
  }

  Future<double> calculateDailyDiastolicPressureAverage(
      DateTime specificDay) async {
    // Get the start and end time of the specific day
    DateTime startTime =
        DateTime(specificDay.year, specificDay.month, specificDay.day);
    DateTime endTime = DateTime(
        specificDay.year, specificDay.month, specificDay.day, 23, 59, 59);

    // Retrieve the pressure data for the specific day
    List<Pressure> pressureList =
        await db.pressureDao.findPressurebyDate(startTime, endTime);
    if (pressureList.isEmpty) {
      return 0; // Return 0 if no data is available
    }
    // Calculate the sum of  diastolic pressure values
    int diastolicSum = 0;

    for (Pressure pressure in pressureList) {
      diastolicSum += pressure.diastolic;
    }

    // Calculate the average values
    double diastolicAverage = diastolicSum / pressureList.length;

    return diastolicAverage;
  }

  Future<int> calculateDailyMaxDiastolicPressure(DateTime specificDay) async {
    // Get the start and end time of the specific day
    DateTime startTime =
        DateTime(specificDay.year, specificDay.month, specificDay.day);
    DateTime endTime = DateTime(
        specificDay.year, specificDay.month, specificDay.day, 23, 59, 59);

    // Retrieve the pressure data for the specific day
    List<Pressure> pressureList =
        await db.pressureDao.findPressurebyDate(startTime, endTime);

    if (pressureList.isEmpty) {
      return 0; // Return 0 if no data is available
    }

    // Find the maximum diastolic pressure value
    int maxDiastolic = pressureList[0].diastolic;

    for (Pressure pressure in pressureList) {
      if (pressure.diastolic > maxDiastolic) {
        maxDiastolic = pressure.diastolic;
      }
    }

    return maxDiastolic;
  }

// METODI PER PRESSIONE
  Future<List<Pressure>> findAllPressure() async {
    final results = await db.pressureDao.findAllPressure();
    return results;
  } //findAllPressure

  Future<void> insertPressure(Pressure pressure) async {
    await db.pressureDao.insertPressure(pressure);
    notifyListeners();
  } //insertPressure

  //This method wraps the deleteTodo() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> removePressure(Pressure pressure) async {
    await db.pressureDao.deletePressure(pressure);
    notifyListeners();
  } //removePressure

  // METODI PER MET
  Future<List<MET>> findAllMet() async {
    final results = await db.metDao.findAllMet();
    return results;
  } //findAllPressure

  Future<void> insertMet(MET met) async {
    await db.metDao.insertMet(met);
    notifyListeners();
  } //insertPressure

  
}
