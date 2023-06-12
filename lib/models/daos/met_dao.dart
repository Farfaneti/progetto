import 'package:floor/floor.dart';

import '../entities/met.dart';


//Here, we are saying that the following class defines a dao.

@dao
abstract class MetDao {
  //Query #0: SELECT -> this allows to obtain all the entries of the MET-min table of a certain date
  @Query('SELECT * FROM MET WHERE dateTime between :startTime and :endTime ORDER BY dateTime ASC')
  Future<List<MET>> findMetbyDate(DateTime startTime, DateTime endTime);

  //Query #1: SELECT -> this allows to obtain all the entries of the MET table
  @Query('SELECT * FROM MET')
  Future<List<MET>> findAllMet();

  //Query #2: INSERT -> this allows to add a MET in the table
  @insert
  Future<void> insertMet(MET met);

  //Query #3: DELETE -> this allows to delete a MET from the table
  @delete
  Future<void> deleteMet(MET met);

  //Query #4: UPDATE -> this allows to update a MET entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateMet(MET met);
}