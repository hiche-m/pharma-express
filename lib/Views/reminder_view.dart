import 'package:code/Components/main_input_button.dart';
import 'package:code/Utils/fake_data.dart';
import 'package:code/Utils/styling.dart';
import 'package:code/View%20Models/reminder_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReminderView extends StatefulWidget {
  const ReminderView({super.key});

  @override
  State<ReminderView> createState() => _ReminderViewState();
}

class _ReminderViewState extends State<ReminderView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.fromLTRB(40.w, 40.h, 40.w, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text("Reminders", style: Palette.h1),
            ),
            SizedBox(height: 30.h),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.r),
                    child: SizedBox(
                      height: 25.sp,
                      width: 25.sp,
                      child: SvgPicture.asset(
                          "lib/Assets/Icons/Alarm_outline.svg",
                          fit: BoxFit.contain),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Text("Active Reminders",
                    style: Palette.h2.copyWith(color: Colors.green)),
                const Spacer(),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      ReminderVM.showReminderDialog(context);
                    },
                    child: const Icon(
                      Icons.add,
                      color: Palette.secoundaryText,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            // Active Tiles
            for (int index = 0; index < FakeData.instructions.length; index++)
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: ListTile(
                  contentPadding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                  title: Text(
                      FakeData.instructions.values.elementAt(index)!.label!),
                  subtitle: Text(
                    "${ReminderVM.cycleNames.split(";")[FakeData.instructions.values.elementAt(index)!.time!]} | ${FakeData.instructions.values.elementAt(index)!.ppt} pcs | ${FakeData.instructions.values.elementAt(index)!.tpd!} fois",
                  ),
                  trailing: MainInputButton(
                    label: "Details",
                    wide: false,
                    backgroundColor: Palette.selectionBackground,
                    onPressed: () {},
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
              ),
            SizedBox(height: 30.h),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.r),
                    child: SizedBox(
                      height: 25.sp,
                      width: 25.sp,
                      child: SvgPicture.asset("lib/Assets/Icons/Archive.svg",
                          fit: BoxFit.contain),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Text("Past Reminders",
                    style: Palette.h2.copyWith(color: Colors.indigo)),
                const Spacer(),
                FaIcon(FontAwesomeIcons.solidTrashCan,
                    color: Palette.secoundaryText, size: 24.sp),
              ],
            ),
            SizedBox(height: 20.h),
            // Archived Tiles
            for (int index = 0; index < FakeData.instructions.length; index++)
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(10.w, 0, 0, 0),
                title:
                    Text(FakeData.instructions.values.elementAt(index)!.label!),
                subtitle: Text(
                  "${ReminderVM.cycleNames.split(";")[FakeData.instructions.values.elementAt(index)!.time!]} | ${FakeData.instructions.values.elementAt(index)!.ppt} pcs | ${FakeData.instructions.values.elementAt(index)!.tpd!} fois",
                ),
                trailing: MainInputButton(
                  label: "Details",
                  wide: false,
                  backgroundColor: Palette.selectionBackground,
                  onPressed: () {},
                ),
              ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    ));
  }
}
