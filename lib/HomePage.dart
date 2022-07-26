import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/DB/DBConaction.dart';
import 'package:habit_tracker/Screens/AddHabitScreen.dart';
import 'package:habit_tracker/model/habit.dart';

import 'package:table_calendar/table_calendar.dart';

import 'Screens/AllHabits.dart';
import 'Screens/TodayScreen.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Habit> habits = [];
  List<Habit> todayHabits = [];
  int currentIndex = 0;
  double tableHeight = 0;
  Widget CurrentLeading = Text("Habit list");

  Refresh() async {
    habits = await connection.instance.readAllHabits();
    todayHabits = await connection.instance.realAllHaibtsByDay();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: GestureDetector(
          onTap: (() {
            showDialog(
                context: context,
                builder: (context) => AddHabitScreen(
                      function: Refresh,
                    ));
          }),
          child: Container(
            margin: EdgeInsets.only(right: 290.w),
            height: 100.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ], color: Colors.white, borderRadius: BorderRadius.circular(100.r)),
            child: const TextButton(
              onPressed: null,
              child: Text(
                "+ Add new habit",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          actions: const [
            IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.more_vert_outlined,
                  color: Colors.black,
                ))
          ],
          leadingWidth: 500.w,
          leading: currentIndex == 1
              ? GestureDetector(
                  onTap: () {
                    tableHeight == 0 ? tableHeight = 500.h : tableHeight = 0;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.all(40.w),
                    child: Row(
                      children: [
                        Text(
                          "Today",
                          style: TextStyle(
                              color: Color.fromARGB(255, 112, 112, 112),
                              fontWeight: FontWeight.bold,
                              fontSize: 70.sp),
                        ),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: Color.fromARGB(255, 112, 112, 112),
                        )
                      ],
                    ),
                  ),
                )
              : Container(
                  margin: EdgeInsets.all(30.w),
                  child: Text(
                    'Habit list',
                    style: TextStyle(
                        color: Color.fromARGB(255, 112, 112, 112),
                        fontWeight: FontWeight.bold,
                        fontSize: 70.sp),
                  )),
          backgroundColor: const Color.fromARGB(255, 240, 240, 240),
          elevation: 0,
        ),
        bottomNavigationBar: SizedBox(
          height: 150.h,
          child: Stack(children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 150.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      currentIndex = 0;
                      setState(() {});
                    },
                    child: Column(
                      children: [
                        SizedBox(
                            width: 70.w,
                            height: 70.h,
                            child: Image.asset(currentIndex == 0
                                ? 'assets/menuSelected.png'
                                : 'assets/menu.png')),
                        const Text("All habits")
                      ],
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      currentIndex = 1;
                      setState(() {});
                    },
                    child: Column(
                      children: [
                        SizedBox(
                            width: 70.w,
                            height: 70.h,
                            child: Image.asset(currentIndex == 1
                                ? 'assets/todaySelected.png'
                                : 'assets/today.png')),
                        const Text("Today")
                      ],
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
        body: Container(
            color: const Color.fromARGB(255, 240, 240, 240),
            child: currentIndex == 0
                ? AllHabits(
                    habits: habits,
                    function: Refresh,
                  )
                : TodayScreen(tableHeight, Refresh, habits)));
  }
}
