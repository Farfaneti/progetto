import 'dart:async';

import 'package:floor/floor.dart';
import 'package:progetto/screens/exercise_dao.dart';
import 'package:progetto/screens/pressure_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../screens/date_timeconverter.dart';
import '../screens/exercise.dart';
import '../screens/pressure.dart';



//Here, we are importing the entities and the daos of the database

//The generated code will be in database.g.dart
part 'db.g.dart';

//Here we are saying that this is the first version of the Database and it has just 1 entity, i.e., Meal.
//We also added a TypeConverter to manage the DateTime of a Meal entry, since DateTimes are not natively
//supported by Floor.
@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [Ex, Pressure])
abstract class AppDatabase extends FloorDatabase {
  //Add all the daos as getters here
  ExerciseDao get exerciseDao;
  PressureDao get pressureDao;
}//AppDatabase

