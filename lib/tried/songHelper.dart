import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_audio/tried/songInfo.dart';
import 'package:sqflite/sqflite.dart';

final String tableSong="songsList";
final int columnId=0;
final String columntitle="title";

class SongHelper{
  static Database? _database;
  static SongHelper? _songHelper;

  SongHelper._createInstance();
  factory SongHelper(){
    if(_songHelper==null){
      _songHelper=SongHelper._createInstance();

    }
    return _songHelper!;
  }
  Future<Database?> get database async {
    if(_database==null)
      {
        _database=await initializeDatabase();

      }
    return _database;
  }

  Future<Database> initializeDatabase() async
  {
    var dir = await getDatabasesPath();
    var path = dir + "alarm.db";
    print("dir: $dir");
    var database = await openDatabase(
        path,
        version: 1,
        onCreate: (database, version) async {
          await database.execute('''
          create table $tableSong(
          $columnId integer primary key automatic,
          $columntitle text not null)
          ''');
          print("exicuted");
        }
    );
    return database;
  }

    void insertSong(SongInfo songInfo) async{

      var db=await this.database;
      var result= db?.insert(tableSong, songInfo.toMap());
      print('result: $result');
  }

}
