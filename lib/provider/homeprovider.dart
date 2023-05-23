import 'dart:math';

import 'package:flutter/material.dart';
import 'package:progetto/models/db.dart';
import 'package:progetto/services/server_string.dart';
import 'package:progetto/utils/shared_preferences.dart';


import '../services/impact.dart';


// this is the change notifier. it will manage all the logic of the home page: fetching the correct data from the database
// and on startup fetching the data from the online services
class HomeProvider extends ChangeNotifier {
  // data to be used by the UI
  late List<exercise>  exercises;
 
  // data fetched from external services or db
  late List<exercise> _exercisesDB;
 
  // selected day of data to be shown
  DateTime showDate = DateTime.now().subtract(const Duration(days: 1));
  
  DateTime lastFetch = DateTime.now().subtract(Duration(days: 2));
  final ImpactService impactService;

  bool doneInit = false;

  HomeProvider( this.impactService) {
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
    //_heartRatesDB = fitbitGen.fetchHR();
    // if (lastFetch.difference(DateTime.now()).inMinutes.abs() > 5) {
    //   _pm25DB = await _fetchPurpleAir(lastFetch);
    //   aqi = _calculateAqi().toInt();
    // }

    _exercisesDB = await impactService.getDataFromDay(lastFetch);
   
  }

  // method to trigger a new data fetching
  void refresh() {
    _fetchAndCalculate();
    getDataOfDay(showDate);
  }


  // method to select only the data of the chosen day
  void getDataOfDay(DateTime showDate) {
    this.showDate = showDate;
    exercises = _exercisesDB
        .where((element) => element.timestamp.day == showDate.day)
        .toList()
        .reversed
        .toList();
    
    // after selecting all data we notify all consumers to rebuild
    notifyListeners();
  }

  
}