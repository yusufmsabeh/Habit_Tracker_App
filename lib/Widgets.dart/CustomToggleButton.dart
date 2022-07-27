import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomToggleButton extends FormField<bool> {
  CustomToggleButton(FormFieldValidator<bool>? validator,
      List<bool> _isSelected, Function function)
      : super(
            validator: validator,
            initialValue: false,
            builder: (State) {
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 169, 169, 169),
                        borderRadius: BorderRadius.circular(25.r)),
                    child: ToggleButtons(
                        onPressed: (index) {
                          function(index);
                        },
                        borderColor: Colors.white,
                        selectedBorderColor: Colors.white,
                        borderWidth: 15.h,
                        color: Colors.white,
                        selectedColor: Colors.white,
                        fillColor: const Color.fromARGB(255, 108, 186, 212),
                        borderRadius: BorderRadius.circular(10.r),
                        constraints: BoxConstraints(
                          minWidth: State.context.locale.toString == 'en'
                              ? (MediaQuery.of(State.context).size.width - 36) /
                                  9
                              : (MediaQuery.of(State.context).size.width - 36) /
                                  10,
                          minHeight:
                              (MediaQuery.of(State.context).size.height - 36) /
                                  20,
                        ),
                        isSelected: _isSelected,
                        children: [
                          Text('Mon'.tr()),
                          Text('Tue'.tr()),
                          Text('Wed'.tr()),
                          Text('Thu'.tr()),
                          Text('Fri'.tr()),
                          Text('Sat'.tr()),
                          Text('Sun'.tr()),
                        ]),
                  ),
                  State.hasError
                      ? SizedBox(
                          width: double.infinity,
                          child: Text(
                            State.errorText!,
                            style: TextStyle(
                                color: const Color.fromARGB(255, 194, 32, 20),
                                fontSize: 36.sp),
                            textAlign: State.context.locale.toString() == 'en'
                                ? TextAlign.left
                                : TextAlign.right,
                          ),
                        )
                      : const SizedBox()
                ],
              );
            });
}
