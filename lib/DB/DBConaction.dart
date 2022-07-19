import 'dart:ffi';

import 'package:habit_tracker/model/habit.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class connection {
  static final connection instance = connection._init();
  static Database? _database;

  connection._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('habit_database2');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path,
        version: 1, onCreate: _createDB, onConfigure: _onConfigure);
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future _createDB(Database db, int verison) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final nameType = 'TEXT';
    final targetType = 'INTEGER';
    final doneType = 'INTEGER';

    await db.execute(
        'CREATE TABLE $tableHabit (${Habitfields.id} $idType ,${Habitfields.name} $nameType,${Habitfields.target} $targetType ,${Habitfields.done} $doneType )');
  }

  Future<List<Habit>> readAllHabits() async {
    final db = await instance.database;
    final maps = await db.query(tableHabit, columns: Habitfields.values);
    print(maps);
    List<Habit> allHabits = maps.map((e) => Habit.fromJson(e)).toList();
    return allHabits;
  }

  Future<Habit> insertHabit(Habit habit) async {
    final db = await instance.database;
    final id = await db.insert(tableHabit, habit.toJson());
    return habit.copy(id: id);
  }
}
