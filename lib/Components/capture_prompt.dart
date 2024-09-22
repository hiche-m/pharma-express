import 'package:code/Utils/styling.dart';
import 'package:code/View%20Models/camera_view_model.dart';
import 'package:code/View%20Models/home_view_model.dart';
import 'package:code/View%20Models/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CapturePrompt extends StatelessWidget {
  const CapturePrompt({super.key});

  @override
  Widget build(BuildContext context) {
    if (CameraVM.capturedImage == null) {
      Navigator.of(context).pop();
    }
    return Stack(
      children: [
        GestureDetector(
          onVerticalDragEnd: (details) => details.primaryVelocity! >= 2000
              ? Navigator.of(context).pop()
              : null,
          child: Scaffold(
              body: SizedBox(
            height: 1.sh,
            width: 1.sw,
            child: Hero(
              tag: "captured_picture",
              child: Image.file(
                CameraVM.capturedImage!,
                fit: BoxFit.cover,
              ),
            ),
          )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              width: 1.sw,
              decoration: BoxDecoration(
                color: Palette.backgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Palette.secoundaryText,
                          fontSize: 20.sp,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        HomeVM.pageIndex = 0;
                        HomeVM.animateToPage(0, 1);
                        MapVM.loadAcceptedLocations(CameraVM.capturedImage!);
                      },
                      child: CircleAvatar(
                        radius: 55.r,
                        backgroundColor: Palette.mainColor,
                        child: const FaIcon(
                          FontAwesomeIcons.check,
                          color: Palette.superLight,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
