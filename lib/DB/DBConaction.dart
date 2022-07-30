import 'dart:ffi';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class connection {
  static final connection instance = connection._init();
  static Database? _database;

  connection._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('habit_database10');
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
    final badgeType = 'TEXT';
    String habitId = Habitfields.id;

    await db.execute(
        'CREATE TABLE $tableHabit (${Habitfields.id} $idType ,${Habitfields.name} $nameType,${Habitfields.target} $targetType ,${Habitfields.done} $doneType,${Habitfields.badge} $badgeType )');
    await db.execute(
        'CREATE TABLE habits_days (id INTEGER , day INTEGER, FOREIGN KEY (id) REFERENCES $tableHabit($habitId) )');
  }

  Future<List<Habit>> readAllHabits() async {
    final db = await instance.database;
    final maps = await db.query(tableHabit, columns: Habitfields.values);

    List<Habit> allHabits = maps.map((e) => Habit.fromJson(e)).toList();
    final maps2 = await db.query('habits_days', columns: ['id', 'day']);

    return allHabits;
  }

  Future<Habit> insertHabit(Habit habit, List<int> day) async {
    final db = await instance.database;
    final id = await db.insert(tableHabit, habit.toJson());
    day.forEach((element) async {
      await db.insert('habits_days', {'id': id, 'day': element});
    });

    return habit.copy(id: id);
  }

  Future<List<Habit>> realAllHaibtsByDay() async {
    final db = await instance.database;

    final habitsId = await db.query('habits_days',
        columns: ['id'], where: 'day =?', whereArgs: [DateTime.now().weekday]);

    List<dynamic> idies = habitsId.map((e) => e['id']).toList();
    List<Habit> habits = [];
    String habitIdColumn = Habitfields.id;

    idies.forEach((element) async {
      final habitById = await db.query(tableHabit,
          columns: Habitfields.values,
          where: '$habitIdColumn = ?',
          whereArgs: [element as int]);
      habits.add(Habit.fromJson(habitById[0]));
    });

    return habits;
  }

  Future<List<Habit>> realAllHaibtsBySpecDay(DateTime dateTime) async {
    final db = await instance.database;

    final habitsId = await db.query('habits_days',
        columns: ['id'], where: 'day =?', whereArgs: [dateTime.weekday]);

    List<dynamic> idies = habitsId.map((e) => e['id']).toList();
    List<Habit> habits = [];
    String habitIdColumn = Habitfields.id;

    idies.forEach((element) async {
      final habitById = await db.query(tableHabit,
          columns: Habitfields.values,
          where: '$habitIdColumn = ?',
          whereArgs: [element as int]);
      habits.add(Habit.fromJson(habitById[0]));
    });

    return habits;
  }

  Future<Habit> realHabitById(id) async {
    final db = await instance.database;
    String idColumn = Habitfields.id;
    final habitById = await db.query(tableHabit,
        columns: Habitfields.values, where: '$idColumn=?', whereArgs: [id]);

    return Habit.fromJson(habitById[0]);
  }

  updateDone(id) async {
    final db = await instance.database;
    Habit habit = await realHabitById(id);

    var values = {
      Habitfields.id: id,
      Habitfields.name: habit.name,
      Habitfields.target: habit.target,
      Habitfields.done: habit.done! + 1
    };
    String idField = Habitfields.id;
    db.update(tableHabit, values, where: '$idField=?', whereArgs: [id]);
  }

  deleteHabit(id) async {
    final db = await instance.database;
    String idField = Habitfields.id;
    db.delete("habits_days", where: 'id=?', whereArgs: [id]);
    db.delete(tableHabit, where: '$idField=?', whereArgs: [id]);
  }

  getHabitDays(int? habitId) async {
    final db = await instance.database;
    List habitDaysMap =
        await db.query('habits_days', where: 'id=?', whereArgs: [habitId]);
    List<bool> isSelected = List.generate(7, (index) => false);
    print(habitDaysMap);
    habitDaysMap.forEach(
      (element) {
        isSelected[element['day'] - 1] = true;
      },
    );

    return isSelected;
  }

  updateHabit(Habit habit, List<int> days) async {
    final db = await instance.database;
    await db.update(tableHabit, habit.toJsonWithdone(),
        where: '${Habitfields.id}=?', whereArgs: [habit.id]);

    // for (int i = 0; i < 7; i++) {
    //   await db.update('habits_days', {'id': habit.id, 'day': days[i]},
    //       where: 'id=? and day=?', whereArgs: [habit.id, preValues[i]]);
    // }
    await db.delete('habits_days', where: 'id=?', whereArgs: [habit.id]);
    days.forEach((element) async {
      await db.insert(
        'habits_days',
        {'id': habit.id, 'day': element},
      );
    });
  }
}
