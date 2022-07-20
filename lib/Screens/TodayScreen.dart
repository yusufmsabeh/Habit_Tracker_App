import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class TodayScreen extends StatefulWidget {
  static final now = DateTime.now();
  final table = TableCalendar(
    calendarStyle: CalendarStyle(rangeHighlightColor: Colors.red),
    rowHeight: 80.h,
    firstDay: DateTime.utc(2010, 10, 16),
    lastDay: DateTime.utc(2030, 3, 14),
    focusedDay: DateTime.now(),
  );
  double todayHieght;
  TodayScreen(this.todayHieght);

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
            height: widget.todayHieght,
            duration: const Duration(milliseconds: 500),
            child: SingleChildScrollView(child: widget.table))
      ],
    );
  }
}
