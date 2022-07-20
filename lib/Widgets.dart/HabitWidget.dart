import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HabitWidget extends StatelessWidget {
  Habit habit;
  late double progress;
  HabitWidget({required this.habit, Key? key}) : super(key: key) {
    progress = (habit.done! / habit.target) * 100;
  }

  @override
  Widget build(BuildContext context) {
    var controller;
    return Container(
      height: 500.h,
      margin: EdgeInsets.only(bottom: 50.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.r), color: Colors.white),
      child: Column(
        children: [
          Container(
            // margin: EdgeInsets.only(bottom: 100.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.all(30.w),
                  height: 60.h,
                  width: 60.w,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/delete.png'))),
                ),
                Container(
                  margin: EdgeInsets.all(30.w),
                  height: 60.h,
                  width: 60.w,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/edit.png'))),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 500.w,
                  height: 300.h,
                  child: SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                              widget: Text("$progress %",
                                  style: TextStyle(fontSize: 70.sp)),
                              positionFactor: 0.1,
                              angle: 90,
                            )
                          ],
                          pointers: <GaugePointer>[
                            RangePointer(
                              color: Color.fromARGB(255, 117, 184, 213),
                              value: 1,
                              cornerStyle: CornerStyle.bothCurve,
                              width: 0.2,
                              sizeUnit: GaugeSizeUnit.factor,
                            )
                          ],
                          minimum: 0,
                          maximum: habit.target / 1,
                          showLabels: false,
                          showTicks: false,
                          axisLineStyle: AxisLineStyle(
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
    );
  }
}
