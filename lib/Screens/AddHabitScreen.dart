import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/DB/DBConaction.dart';
import 'package:habit_tracker/model/habit.dart';

class AddHabitScreen extends StatefulWidget {
  Function function;
  AddHabitScreen({required this.function, Key? key}) : super(key: key);

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final _formState = GlobalKey<FormState>();

  List<bool> _isSelected = List.generate(7, (index) => false);
  //List<String> days = ['M', 'T', 'W', 'R', 'F', 'U', 'S'];
  final nameController = TextEditingController();
  final tragetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(35.r))),
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.all(10),
        child: Form(
          key: _formState,
          child: Container(
            margin: EdgeInsets.all(50.w),
            height: 1250.h,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(100.w),
                  child: Text(
                    "Add Habit",
                    style: TextStyle(
                        color: Color.fromARGB(255, 145, 197, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: 80.sp),
                  ),
                ),
                Container(
                  // margin: EdgeInsets.only(bottom: 20.w),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Name",
                    style: TextStyle(
                        fontSize: 50.sp,
                        color: Color.fromARGB(255, 183, 183, 183)),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 90.w),
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) return 'This field is required';
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan),
                          ),
                          hintText: "Name",
                          focusColor: Color.fromARGB(255, 145, 197, 255)),
                    )),
                Container(
                  // margin: EdgeInsets.only(bottom: 20.w),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Schedule",
                    style: TextStyle(
                        fontSize: 50.sp,
                        color: Color.fromARGB(255, 183, 183, 183)),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 169, 169, 169),
                      borderRadius: BorderRadius.circular(25.r)),
                  child: ToggleButtons(
                      onPressed: (index) {
                        setState(() {
                          _isSelected[index] = !_isSelected[index];
                        });
                      },
                      borderColor: Colors.white,
                      selectedBorderColor: Colors.white,
                      borderWidth: 15.h,
                      color: Colors.white,
                      selectedColor: Colors.white,
                      fillColor: Color.fromARGB(255, 108, 186, 212),
                      borderRadius: BorderRadius.circular(10.r),
                      constraints: BoxConstraints(
                          minHeight:
                              (MediaQuery.of(context).size.height - 36) / 20,
                          minWidth:
                              (MediaQuery.of(context).size.width - 36) / 9),
                      children: [
                        Text('Mon'),
                        Text('Tue'),
                        Text('Wed'),
                        Text('Thu'),
                        Text('Fri'),
                        Text('Sat'),
                        Text('Sun '),
                      ],
                      isSelected: _isSelected),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 90.w),
                ),
                Container(
                    // margin: EdgeInsets.only(bottom: 20.w),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Target",
                      style: TextStyle(
                          fontSize: 50.sp,
                          color: Color.fromARGB(255, 183, 183, 183)),
                    )),
                Container(
                    margin: EdgeInsets.only(bottom: 90.w),
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'This field is required';
                          else if (int.parse(value) == 0)
                            return 'The target can not be zero';
                        },
                        controller: tragetController,
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                            hintText: "Target",
                            focusColor: Color.fromARGB(255, 145, 197, 255)))),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: Color.fromARGB(255, 145, 197, 255),
                              fontWeight: FontWeight.bold),
                        )),
                    TextButton(
                        onPressed: () {
                          if (_formState.currentState!.validate()) {
                            List<int> daysToInsert = [];

                            for (int i = 0; i < _isSelected.length; i++) {
                              if (_isSelected[i]) {
                                daysToInsert.add(i + 1);
                              }
                            }
                            connection.instance.insertHabit(
                                Habit(
                                    name: nameController.text,
                                    target: int.parse(tragetController.text)),
                                daysToInsert);
                            widget.function();
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          'SAVE',
                          style: TextStyle(
                              color: Color.fromARGB(255, 145, 197, 255),
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
