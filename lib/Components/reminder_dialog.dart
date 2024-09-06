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
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Palette.backgroundColor,
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
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Libellé"),
              Text("Dernier Jour:"),
              Text("Nombre de fois - 1 fois"),
            ],
          ),
        ),
      ),
    );
  }
}
