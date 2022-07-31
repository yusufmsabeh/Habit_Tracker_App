import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class StatisticsScreen extends StatefulWidget {
  Habit habit;
  late double progress;

  StatisticsScreen({Key? key, required this.habit}) : super(key: key) {
    progress = (habit.done! / habit.target) * 100;
  }

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 53, 175, 190),
          title: Text("Statistics".tr())),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
            Container(
              height: 400.h,
              margin: EdgeInsets.only(bottom: 50.w),
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(40.r),
                  color: Colors.white),
              child: Row(children: [
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Preogresss".tr(),
                      style: TextStyle(fontSize: 80.sp),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "${widget.habit.done}/${widget.habit.target}",
                      style: TextStyle(fontSize: 60.sp),
                    )
                  ],
                ),
                Spacer(),
                SizedBox(
                    width: 500.w,
                    height: 300.h,
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                widget: Text(" ${widget.progress.floor()} %",
                                    style: TextStyle(fontSize: 70.sp)),
                                positionFactor: 0.1,
                                angle: 90,
                              )
                            ],
                            pointers: <GaugePointer>[
                              RangePointer(
                                color: const Color.fromARGB(255, 117, 184, 213),
                                value: widget.habit.done! / 1,
                                cornerStyle: CornerStyle.bothCurve,
                                width: 0.2,
                                sizeUnit: GaugeSizeUnit.factor,
                              )
                            ],
                            minimum: 0,
                            maximum: widget.habit.target / 1,
                            showLabels: false,
                            showTicks: false,
                            axisLineStyle: const AxisLineStyle(
                                thickness: 0.2,
                                cornerStyle: CornerStyle.bothCurve,
                                color: Color.fromARGB(255, 240, 240, 240),
                                thicknessUnit: GaugeSizeUnit.factor))
                      ],
                    ))
              ]),
            )
          ],
        ),
      ),
    );
  }
}
