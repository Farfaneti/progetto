import 'dart:async';

import 'package:floor/floor.dart';
import 'package:progetto/models/daos/exercise_dao.dart';
import 'package:progetto/models/daos/met_dao.dart';
import 'package:progetto/models/daos/pressure_dao.dart';
import 'package:progetto/converters/date_timeconverter.dart';
import 'package:progetto/models/entities/exercise.dart';
import 'package:progetto/models/entities/pressure.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'entities/met.dart';

//Here, we are importing the entities and the daos of the database

//The generated code will be in database.g.dart
part 'db.g.dart';


@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [Ex, Pressure, MET])
abstract class AppDatabase extends FloorDatabase {
  //Add all the daos as getters here
  ExerciseDao get exerciseDao;
  PressureDao get pressureDao;
  MetDao get metDao;
}//AppDatabase

