import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/DB/DBConaction.dart';
import 'package:habit_tracker/Widgets.dart/HabitWidget.dart';
import 'package:habit_tracker/model/habit.dart';

class AllHabits extends StatefulWidget {
  Function function;
  List<Habit> habits;
  AllHabits({required this.function, required this.habits, Key? key})
      : super(key: key);

  @override
  State<AllHabits> createState() => _AllHabitsState();
}

class _AllHabitsState extends State<AllHabits> {
  // List<Habit> habits = [];
  // void readAllHabits() async {
  //   habits = await connection.instance.readAllHabits();

  //   setState(() {});
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   readAllHabits();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40.w),
      child: ListView.builder(
          itemCount: widget.habits.length,
          itemBuilder: ((context, index) => HabitWidget(
                habit: widget.habits[index],
                function: widget.function,
                function2: widget.function,
              ))),
    );
  }
}
