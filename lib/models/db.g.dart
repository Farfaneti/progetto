// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ExerciseDao? _exerciseDaoInstance;

  PressureDao? _pressureDaoInstance;

  MetDao? _metDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Ex` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `activityName` TEXT NOT NULL, `calories` INTEGER NOT NULL, `duration` REAL NOT NULL, `dateTime` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Pressure` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `systolic` INTEGER NOT NULL, `diastolic` INTEGER NOT NULL, `dateTime` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MET` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `met` REAL NOT NULL, `dateTime` INTEGER NOT NULL, `exID` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ExerciseDao get exerciseDao {
    return _exerciseDaoInstance ??= _$ExerciseDao(database, changeListener);
  }

  @override
  PressureDao get pressureDao {
    return _pressureDaoInstance ??= _$PressureDao(database, changeListener);
  }

  @override
  MetDao get metDao {
    return _metDaoInstance ??= _$MetDao(database, changeListener);
  }
}

class _$ExerciseDao extends ExerciseDao {
  _$ExerciseDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _exInsertionAdapter = InsertionAdapter(
            database,
            'Ex',
            (Ex item) => <String, Object?>{
                  'id': item.id,
                  'activityName': item.activityName,
                  'calories': item.calories,
                  'duration': item.duration,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _exUpdateAdapter = UpdateAdapter(
            database,
            'Ex',
            ['id'],
            (Ex item) => <String, Object?>{
                  'id': item.id,
                  'activityName': item.activityName,
                  'calories': item.calories,
                  'duration': item.duration,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _exDeletionAdapter = DeletionAdapter(
            database,
            'Ex',
            ['id'],
            (Ex item) => <String, Object?>{
                  'id': item.id,
                  'activityName': item.activityName,
                  'calories': item.calories,
                  'duration': item.duration,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Ex> _exInsertionAdapter;

  final UpdateAdapter<Ex> _exUpdateAdapter;

  final DeletionAdapter<Ex> _exDeletionAdapter;

  @override
  Future<List<Ex>> findExercisebyDate(
    DateTime startTime,
    DateTime endTime,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Ex WHERE dateTime between ?1 and ?2 ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => Ex(row['id'] as int?, row['activityName'] as String, row['calories'] as int, row['duration'] as double, _dateTimeConverter.decode(row['dateTime'] as int)),
        arguments: [
          _dateTimeConverter.encode(startTime),
          _dateTimeConverter.encode(endTime)
        ]);
  }

  @override
  Future<List<Ex>> findAllExercise() async {
    return _queryAdapter.queryList('SELECT * FROM Ex',
        mapper: (Map<String, Object?> row) => Ex(
            row['id'] as int?,
            row['activityName'] as String,
            row['calories'] as int,
            row['duration'] as double,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<Ex?> findFirstDayInDb() async {
    return _queryAdapter.query('SELECT * FROM Ex ORDER BY dateTime ASC LIMIT 1',
        mapper: (Map<String, Object?> row) => Ex(
            row['id'] as int?,
            row['activityName'] as String,
            row['calories'] as int,
            row['duration'] as double,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<Ex?> findLastDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Ex ORDER BY dateTime DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => Ex(
            row['id'] as int?,
            row['activityName'] as String,
            row['calories'] as int,
            row['duration'] as double,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<void> insertExercise(Ex exercisesData) async {
    await _exInsertionAdapter.insert(exercisesData, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateExercise(Ex exercisesData) async {
    await _exUpdateAdapter.update(exercisesData, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteExercise(Ex exercisesData) async {
    await _exDeletionAdapter.delete(exercisesData);
  }
}

class _$PressureDao extends PressureDao {
  _$PressureDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _pressureInsertionAdapter = InsertionAdapter(
            database,
            'Pressure',
            (Pressure item) => <String, Object?>{
                  'id': item.id,
                  'systolic': item.systolic,
                  'diastolic': item.diastolic,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _pressureUpdateAdapter = UpdateAdapter(
            database,
            'Pressure',
            ['id'],
            (Pressure item) => <String, Object?>{
                  'id': item.id,
                  'systolic': item.systolic,
                  'diastolic': item.diastolic,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _pressureDeletionAdapter = DeletionAdapter(
            database,
            'Pressure',
            ['id'],
            (Pressure item) => <String, Object?>{
                  'id': item.id,
                  'systolic': item.systolic,
                  'diastolic': item.diastolic,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Pressure> _pressureInsertionAdapter;

  final UpdateAdapter<Pressure> _pressureUpdateAdapter;

  final DeletionAdapter<Pressure> _pressureDeletionAdapter;

  @override
  Future<List<Pressure>> findPressurebyDate(
    DateTime startTime,
    DateTime endTime,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Pressure WHERE dateTime between ?1 and ?2 ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => Pressure(row['id'] as int?, row['systolic'] as int, row['diastolic'] as int, _dateTimeConverter.decode(row['dateTime'] as int)),
        arguments: [
          _dateTimeConverter.encode(startTime),
          _dateTimeConverter.encode(endTime)
        ]);
  }

  @override
  Future<List<Pressure>> findAllPressure() async {
    return _queryAdapter.queryList('SELECT * FROM Pressure',
        mapper: (Map<String, Object?> row) => Pressure(
            row['id'] as int?,
            row['systolic'] as int,
            row['diastolic'] as int,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<Pressure?> findFirstDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Pressure ORDER BY dateTime ASC LIMIT 1',
        mapper: (Map<String, Object?> row) => Pressure(
            row['id'] as int?,
            row['systolic'] as int,
            row['diastolic'] as int,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<Pressure?> findLastDayInDb() async {
    return _queryAdapter.query(
        'SELECT * FROM Pressure ORDER BY dateTime DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => Pressure(
            row['id'] as int?,
            row['systolic'] as int,
            row['diastolic'] as int,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<void> insertPressure(Pressure pressureData) async {
    await _pressureInsertionAdapter.insert(
        pressureData, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePressure(Pressure pressureData) async {
    await _pressureUpdateAdapter.update(
        pressureData, OnConflictStrategy.replace);
  }

  @override
  Future<void> deletePressure(Pressure pressureData) async {
    await _pressureDeletionAdapter.delete(pressureData);
  }
}

class _$MetDao extends MetDao {
  _$MetDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _mETInsertionAdapter = InsertionAdapter(
            database,
            'MET',
            (MET item) => <String, Object?>{
                  'id': item.id,
                  'met': item.met,
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'exID': item.exID
                }),
        _mETUpdateAdapter = UpdateAdapter(
            database,
            'MET',
            ['id'],
            (MET item) => <String, Object?>{
                  'id': item.id,
                  'met': item.met,
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'exID': item.exID
                }),
        _mETDeletionAdapter = DeletionAdapter(
            database,
            'MET',
            ['id'],
            (MET item) => <String, Object?>{
                  'id': item.id,
                  'met': item.met,
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'exID': item.exID
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MET> _mETInsertionAdapter;

  final UpdateAdapter<MET> _mETUpdateAdapter;

  final DeletionAdapter<MET> _mETDeletionAdapter;

  @override
  Future<List<MET>> findMetbyDate(
    DateTime startTime,
    DateTime endTime,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM MET WHERE dateTime between ?1 and ?2 ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => MET(row['id'] as int?, row['met'] as double, _dateTimeConverter.decode(row['dateTime'] as int), row['exID'] as int?),
        arguments: [
          _dateTimeConverter.encode(startTime),
          _dateTimeConverter.encode(endTime)
        ]);
  }

  @override
  Future<List<MET>> findAllMet() async {
    return _queryAdapter.queryList('SELECT * FROM MET',
        mapper: (Map<String, Object?> row) => MET(
            row['id'] as int?,
            row['met'] as double,
            _dateTimeConverter.decode(row['dateTime'] as int),
            row['exID'] as int?));
  }

  @override
  Future<void> insertMet(MET met) async {
    await _mETInsertionAdapter.insert(met, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateMet(MET met) async {
    await _mETUpdateAdapter.update(met, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteMet(MET met) async {
    await _mETDeletionAdapter.delete(met);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
