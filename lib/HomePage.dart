import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  static final now = DateTime.now();
  final table = TableCalendar(
    calendarStyle: CalendarStyle(rangeHighlightColor: Colors.red),
    rowHeight: 80.h,
    firstDay: DateTime.utc(2010, 10, 16),
    lastDay: DateTime.utc(2030, 3, 14),
    focusedDay: DateTime.now(),
  );
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  double tableHeight = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Container(
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
          child: Text("+ Add new habit"),
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
        leading: GestureDetector(
          onTap: () {
            tableHeight == 0 ? tableHeight = 500.h : tableHeight = 0;
            setState(() {});
          },
          child: Container(
            margin: EdgeInsets.all(30.w),
            child: Row(
              children: [
                Text(
                  "Today",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 70.sp),
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
        elevation: 0,
      ),
      bottomNavigationBar: SizedBox(
        height: 150.h,
        child: Stack(children: [
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: Container(
          //     height: 100.h,
          //     padding: EdgeInsets.symmetric(horizontal: 20.w),
          //     decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(100.r)),
          //     child: const TextButton(
          //       onPressed: null,
          //       child: Text("+ Add new habit"),
          //     ),
          //   ),
          // ),
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
        child: Stack(
          children: [
            Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 600.w,
                      height: 600.h,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/HomePage.png'))),
                    ),
                    Text(
                      "Noting to do today",
                      style: TextStyle(
                          fontSize: 100.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 20, 176, 191)),
                    ),
                    Text(
                      "Add Something?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 100.sp,
                          color: const Color.fromARGB(255, 20, 176, 191)),
                    )
                  ]),
            ),
            AnimatedContainer(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 240, 240, 240),
                ),
                height: tableHeight,
                duration: const Duration(milliseconds: 500),
                child: SingleChildScrollView(child: widget.table))
          ],
        ),
      ),
    );
  }
}
