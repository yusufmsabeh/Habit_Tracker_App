import 'dart:convert';

import 'package:flutter/cupertino.dart';

const String tableHabit = 'habit';

class Habitfields {
  static final List<String> values = [id, name, target, done, badge];
  static const String id = '_id';
  static const String name = '_name';
  static const String target = '_target';
  static const String done = '_done';
  static const String badge = '_badge';
}

class Habit {
  final int? id;
  String name;
  int target;
  String badge;
  int? done = 0;
  Habit(
      {this.id,
      required this.name,
      required this.target,
      this.done,
      required this.badge});

  Map<String, dynamic> toJson() => {
        Habitfields.id: id,
        Habitfields.name: name,
        Habitfields.target: target,
        Habitfields.done: 0,
        Habitfields.badge: badge
      };

  Map<String, dynamic> toJsonWithdone() => {
        Habitfields.id: id,
        Habitfields.name: name,
        Habitfields.target: target,
        Habitfields.done: done,
        Habitfields.badge: badge
      };

  static Habit fromJson(Map json) => Habit(
      id: json[Habitfields.id] as int,
      name: json[Habitfields.name] as String,
      target: json[Habitfields.target] as int,
      done: json[Habitfields.done] as int,
      badge: json[Habitfields.badge] as String);

  Habit copy({int? id, String? name, int? target, int? done, String? badge}) =>
      Habit(
          id: id ?? this.id,
          name: name ?? this.name,
          target: target ?? this.target,
          done: done ?? this.done,
          badge: badge ?? this.badge);
}
