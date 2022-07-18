import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(1080, 1920),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          );
        });
  }
}
