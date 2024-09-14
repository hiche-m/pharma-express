import 'package:code/Components/date_input.dart';
import 'package:code/Components/main_input.dart';
import 'package:code/Components/main_input_button.dart';
import 'package:code/Utils/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReminderDialog extends StatefulWidget {
  const ReminderDialog({super.key});

  @override
  State<ReminderDialog> createState() => _ReminderDialogState();
}

class _ReminderDialogState extends State<ReminderDialog> {
  bool isAm = true;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Palette.superLight,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Center(
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: const FaIcon(
                FontAwesomeIcons.arrowLeftLong,
                color: Palette.textColor,
              ),
            ),
          ),
          title: Text(
            "Manual Reminder",
            style: Palette.h2,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(40.w, 20.h, 40.w, 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MainInput(
                        title: "Libellée:",
                        autoFocus: true,
                        showBorder: false,
                      ),
                      SizedBox(height: 20.h),
                      const DateInput(
                        title: 'Dernier Jour:',
                        placeholder: 'dd/MM/yyyy',
                        showBorder: false,
                      ),
                      SizedBox(height: 25.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Nombre de fois - ",
                                style: Palette.h2,
                              ),
                              TextSpan(
                                text: "1 fois",
                                style: TextStyle(
                                  color: Palette.secoundaryText,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ]),
                          ),
                          Row(
                            children: [
                              Container(
                                height: 25.h,
                                width: 25.h,
                                padding: EdgeInsets.all(5.r),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Palette.selectionColor,
                                      width: 2.0),
                                  borderRadius: BorderRadius.circular(9999),
                                ),
                                child: const FittedBox(
                                  fit: BoxFit.contain,
                                  child: FaIcon(
                                    FontAwesomeIcons.minus,
                                    color: Palette.selectionBackground,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Container(
                                height: 25.h,
                                width: 25.h,
                                padding: EdgeInsets.all(5.r),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Palette.mainColor, width: 2.0),
                                  borderRadius: BorderRadius.circular(9999),
                                ),
                                child: const FittedBox(
                                  fit: BoxFit.contain,
                                  child: FaIcon(
                                    FontAwesomeIcons.plus,
                                    color: Palette.darkMain,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 25.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                              child: Text("Nombre de comprimés à la fois")),
                          Row(children: [
                            FaIcon(
                              FontAwesomeIcons.minus,
                              color: Palette.selectionBackground,
                              size: 18.sp,
                            ),
                            Container(
                                padding:
                                    EdgeInsets.fromLTRB(7.5.w, 5.h, 7.5.w, 5.h),
                                margin: EdgeInsets.symmetric(horizontal: 5.w),
                                decoration: BoxDecoration(
                                  color: Palette.backgroundColor,
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Text("1/2")),
                            FaIcon(
                              FontAwesomeIcons.plus,
                              color: Palette.selectionBackground,
                              size: 18.sp,
                            ),
                          ]),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text("Avant Repas"),
                              Radio(
                                  value: 0,
                                  groupValue: 0,
                                  onChanged: ((value) {})),
                            ],
                          ),
                          Row(
                            children: [
                              const Text("Après Repas"),
                              Radio(
                                  value: 1,
                                  groupValue: 0,
                                  onChanged: ((value) {})),
                            ],
                          ),
                          Row(
                            children: [
                              const Text("A jeun"),
                              Radio(
                                  value: 2,
                                  groupValue: 0,
                                  onChanged: ((value) {})),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.spaceBetween,
                        children: [
                          Text("Heure de rappelle"),
                          Row(
                            children: [
                              Container(
                                  padding: EdgeInsets.all(10.r),
                                  decoration: BoxDecoration(
                                    color: Palette.backgroundColor,
                                    border:
                                        Border.all(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Text(
                                    "05",
                                    style: TextStyle(fontSize: 18.sp),
                                  )),
                              const Text(":"),
                              Container(
                                  padding: EdgeInsets.all(10.r),
                                  decoration: BoxDecoration(
                                    color: Palette.backgroundColor,
                                    border:
                                        Border.all(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Text(
                                    "55",
                                    style: TextStyle(fontSize: 18.sp),
                                  )),
                              SizedBox(width: 5.w),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Palette.mainColor, width: 2.0),
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isAm = !isAm;
                                        });
                                      },
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.easeInOut,
                                        padding: EdgeInsets.all(5.r),
                                        color: isAm
                                            ? Palette.mainColor
                                                .withOpacity(0.15)
                                            : Palette.mainColor.withOpacity(0),
                                        child: Text("AM"),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isAm = !isAm;
                                        });
                                      },
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.easeInOut,
                                        padding: EdgeInsets.all(5.r),
                                        color: !isAm
                                            ? Palette.mainColor
                                                .withOpacity(0.15)
                                            : Palette.mainColor.withOpacity(0),
                                        child: Text("PM"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Palette.secoundaryText,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  MainInputButton(
                    label: "Add",
                    wide: false,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
