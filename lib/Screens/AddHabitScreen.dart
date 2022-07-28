import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_tracker/DB/DBConaction.dart';
import 'package:habit_tracker/Widgets.dart/CustomToggleButton.dart';
import 'package:habit_tracker/model/habit.dart';

class AddHabitScreen extends StatefulWidget {
  Function function;
  Habit? habit;
  AddHabitScreen({required this.function, this.habit, Key? key})
      : super(key: key);

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final _formState = GlobalKey<FormState>();

  List<bool> _isSelected = List.generate(7, (index) => false);
  List<String> itemsDropDown = [
    'assets/cards.png',
    'assets/sports.png',
    'assets/book.png',
    'assets/watter.png',
    'assets/healthy-food.png'
  ];
  List<String> itemsDropDownString = [
    'other',
    'sports',
    'studying',
    'drink Water',
    'eat healthy food'
  ];
  String? selectedItem;
  final nameController = TextEditingController();
  final tragetController = TextEditingController();

  void loadHabitIntoControllers() async {
    if (widget.habit != null) {
      nameController.text = widget.habit!.name;
      tragetController.text = widget.habit!.target.toString();
      _isSelected = await connection.instance.getHabitDays(widget.habit!.id);
      selectedItem = widget.habit!.badge;
    }
    setState(() {});
  }

  void changeIsSeletedList(int index) {
    setState(() {
      _isSelected[index] = !_isSelected[index];
    });
  }

  String? ValidaitToggleButton(x) {
    bool x = false;
    for (var element in _isSelected) {
      if (element) x = true;
    }

    if (!x) {
      return "Required".tr();
    }
  }

  @override
  void initState() {
    super.initState();
    selectedItem = itemsDropDown[0];
    loadHabitIntoControllers();
  }

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
            height: context.locale.toString() == 'en' ? 1400.h : 1550.h,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(100.w),
                  child: Text(
                    "AddHabit".tr(),
                    style: TextStyle(
                        color: const Color.fromARGB(255, 145, 197, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: 80.sp),
                  ),
                ),
                Container(
                  // margin: EdgeInsets.only(bottom: 20.w),
                  alignment: context.locale.toString() == 'en'
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Text(
                    "Name".tr(),
                    style: TextStyle(
                        fontSize: 50.sp,
                        color: const Color.fromARGB(255, 183, 183, 183)),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 90.w),
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) return 'Required'.tr();
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.cyan)),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan),
                          ),
                          hintText: "Name".tr(),
                          focusColor: const Color.fromARGB(255, 145, 197, 255)),
                    )),
                Container(
                  // margin: EdgeInsets.only(bottom: 20.w),
                  alignment: context.locale.toString() == 'en'
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Text(
                    "Schedule".tr(),
                    style: TextStyle(
                        fontSize: 50.sp,
                        color: const Color.fromARGB(255, 183, 183, 183)),
                    textAlign: TextAlign.left,
                  ),
                ),
                CustomToggleButton(
                    ValidaitToggleButton, _isSelected, changeIsSeletedList),
                Container(
                  margin: EdgeInsets.only(bottom: 90.w),
                ),
                Container(
                    // margin: EdgeInsets.only(bottom: 20.w),
                    alignment: context.locale.toString() == 'en'
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Text(
                      "Target".tr(),
                      style: TextStyle(
                          fontSize: 50.sp,
                          color: const Color.fromARGB(255, 183, 183, 183)),
                    )),
                Container(
                    margin: EdgeInsets.only(bottom: 90.w),
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Required'.tr();
                          else if (int.parse(value) == 0)
                            return 'Zerofield'.tr();
                        },
                        controller: tragetController,
                        keyboardType: const TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.cyan),
                            ),
                            hintText: "TargetHing".tr(),
                            hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 169, 169, 169),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan))))),
                Row(
                  children: [
                    Container(
                        // margin: EdgeInsets.only(bottom: 20.w),
                        alignment: context.locale.toString() == 'en'
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Text(
                          "Badge".tr(),
                          style: TextStyle(
                              fontSize: 50.sp,
                              color: const Color.fromARGB(255, 183, 183, 183)),
                        )),
                    SizedBox(
                      width: 40.w,
                    ),
                    DropdownButtonHideUnderline(
                        child: DropdownButton<dynamic>(
                      value: selectedItem,
                      onChanged: (value) {
                        selectedItem = value;
                        setState(() {});
                      },
                      items: [
                        ...itemsDropDown.map((e) {
                          return DropdownMenuItem(
                            child: Row(
                              children: [
                                Image.asset(e),
                                SizedBox(
                                  width: 40.w,
                                ),
                                Text(itemsDropDownString[
                                    itemsDropDown.indexOf(e)])
                              ],
                            ),
                            value: e,
                          );
                        }).toList()
                      ],
                    ))
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel".tr(),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 145, 197, 255),
                              fontWeight: FontWeight.bold),
                        )),
                    TextButton(
                        onPressed: () async {
                          if (_formState.currentState!.validate()) {
                            List<int> daysToInsert = [];

                            for (int i = 0; i < _isSelected.length; i++) {
                              if (_isSelected[i]) {
                                daysToInsert.add(i + 1);
                              }
                            }
                            if (widget.habit == null) {
                              await connection.instance.insertHabit(
                                  Habit(
                                      badge: selectedItem!,
                                      name: nameController.text,
                                      target: int.parse(tragetController.text)),
                                  daysToInsert);
                            } else {
                              widget.habit!.badge = selectedItem!;
                              widget.habit!.name = nameController.text;
                              widget.habit!.target =
                                  int.parse(tragetController.text);

                              await connection.instance
                                  .updateHabit(widget.habit!, daysToInsert);
                            }

                            widget.function();
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          'Save'.tr(),
                          style: const TextStyle(
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
