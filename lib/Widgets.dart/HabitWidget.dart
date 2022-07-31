import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/DB/DBConaction.dart';
import 'package:habit_tracker/Screens/AddHabitScreen.dart';
import 'package:habit_tracker/Screens/Statistics.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HabitWidget extends StatelessWidget {
  Habit habit;
  Function function;
  Function function2;
  late double progress;
  HabitWidget(
      {required this.habit,
      required this.function,
      required this.function2,
      Key? key})
      : super(key: key) {
    progress = (habit.done! / habit.target) * 100;
  }

  @override
  Widget build(BuildContext context) {
    // var controller;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (Context) {
          return StatisticsScreen(habit: habit);
        }));
      },
      child: Container(
        height: 500.h,
        margin: EdgeInsets.only(bottom: 50.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.r), color: Colors.white),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    await connection.instance.deleteHabit(habit.id);
                    function2();
                    function();
                  },
                  child: Container(
                    margin: EdgeInsets.all(30.w),
                    height: 60.h,
                    width: 60.w,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/delete.png'))),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AddHabitScreen(
                            function: function,
                            habit: habit,
                          );
                        });
                  },
                  child: Container(
                    margin: EdgeInsets.all(30.w),
                    height: 60.h,
                    width: 60.w,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/edit.png'))),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 500.w,
                    height: 300.h,
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                widget: Text(" ${progress.floor()} %",
                                    style: TextStyle(fontSize: 70.sp)),
                                positionFactor: 0.1,
                                angle: 90,
                              )
                            ],
                            pointers: <GaugePointer>[
                              RangePointer(
                                color: const Color.fromARGB(255, 117, 184, 213),
                                value: habit.done! / 1,
                                cornerStyle: CornerStyle.bothCurve,
                                width: 0.2,
                                sizeUnit: GaugeSizeUnit.factor,
                              )
                            ],
                            minimum: 0,
                            maximum: habit.target / 1,
                            showLabels: false,
                            showTicks: false,
                            axisLineStyle: const AxisLineStyle(
                                thickness: 0.2,
                                cornerStyle: CornerStyle.bothCurve,
                                color: Color.fromARGB(255, 240, 240, 240),
                                thicknessUnit: GaugeSizeUnit.factor))
                      ],
                    )),
                const Spacer(
                  flex: 1,
                ),
                Container(
                  width: 350.w,
                  margin: EdgeInsets.only(right: 150.w),
                  child: Text(
                    habit.name,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 70.sp),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
