import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/DB/DBConaction.dart';
import 'package:habit_tracker/Screens/EmptyHabitScreen.dart';
import 'package:habit_tracker/Widgets.dart/LoadingSpinner.dart';
import 'package:habit_tracker/Widgets.dart/TodayHabit.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:table_calendar/table_calendar.dart';

class TodayScreen extends StatefulWidget {
  Function function;
  List<Habit> habits;
  static final now = DateTime.now();
  final table = TableCalendar(
    calendarStyle: CalendarStyle(rangeHighlightColor: Colors.red),
    rowHeight: 80.h,
    firstDay: DateTime.utc(2010, 10, 16),
    lastDay: DateTime.utc(2030, 3, 14),
    focusedDay: DateTime.now(),
  );
  double todayHieght;
  TodayScreen(this.todayHieght, this.function, this.habits);

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  // List<Habit> habits = [];

  // readAllHabits() async {
  //   habits = await connection.instance.realAllHaibtsByDay();
  //   await Future.delayed(const Duration(seconds: 2), () {});
  //   setState(() {});
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   readAllHabits();
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.habits.isEmpty
            ? EmptyHabitScreen()
            : ListView.builder(
                itemCount: widget.habits.length,
                itemBuilder: (context, index) {
                  return TodayHabit(
                    habit: widget.habits[index],
                    function2: widget.function,
                  );
                }),
        AnimatedContainer(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 240, 240, 240),
            ),
            height: widget.todayHieght,
            duration: const Duration(milliseconds: 500),
            child: SingleChildScrollView(child: widget.table))
      ],
    );
  }
}
