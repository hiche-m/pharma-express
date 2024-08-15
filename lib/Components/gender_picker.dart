import 'package:code/Utils/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GenderPicker extends StatefulWidget {
  const GenderPicker(
      {this.title, this.initialValue, this.onChanged, super.key});

  final String? title;
  final void Function(int?)? onChanged;
  final int? initialValue;

  @override
  State<GenderPicker> createState() => GenderPickerState();
}

class GenderPickerState extends State<GenderPicker> {
  String? error;
  late int selected;
  late List<String> genderList;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selected = widget.initialValue ?? 0;

    genderList = [
      AppLocalizations.of(context)!.male,
      AppLocalizations.of(context)!.female
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: 1.sw,
      duration: const Duration(milliseconds: 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title != null
              ? Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Text(
                    widget.title!,
                    style: Palette.h2,
                  ),
                )
              : const SizedBox(),
          SizedBox(
            height: 45.h,
            child: Row(
              children: [
                for (int index = 0; index < genderList.length; index++)
                  Expanded(
                    child: Row(
                      children: [
                        Radio(
                          value: index,
                          groupValue: selected,
                          onChanged: (int? value) {
                            setState(() {
                              selected = value ?? 0;
                            });
                            if (widget.onChanged != null) {
                              widget.onChanged!(selected);
                            }
                          },
                        ),
                        Text(genderList[index]),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          error != null ? SizedBox(height: 10.h) : const SizedBox(),
          error != null
              ? Text(
                  error!,
                  style: TextStyle(color: Colors.red, fontSize: 16.sp),
                )
              : const SizedBox(),
          /* SizedBox(height: 10.h), */
        ],
      ),
    );
  }
}
