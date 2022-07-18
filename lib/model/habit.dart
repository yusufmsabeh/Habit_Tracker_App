import 'dart:convert';

import 'package:flutter/cupertino.dart';

const String tableHabit = 'habit';

class Habitfields {
  static const String id = '_id';
  static const String name = '_name';
  static const String target = '_target';
  static const String done = '_done';
}

class Habit {
  final int? id;
  String name;
  int target;
  int? done = 0;
  Habit({this.id, required this.name, required this.target, this.done});

  Map<String, dynamic> toJson() => {
        Habitfields.id: id,
        Habitfields.name: name,
        Habitfields.target: target,
        Habitfields.done: done
      };

  static Habit fromJson(Map json) => Habit(
      id: json[Habitfields.id] as int,
      name: json[Habitfields.name] as String,
      target: json[Habitfields.target] as int,
      done: json[Habitfields.done] as int);

  Habit copy({int? id, String? name, int? target, int? done}) => Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      target: target ?? this.target,
      done: done ?? this.done);
}
