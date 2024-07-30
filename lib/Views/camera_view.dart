import 'package:code/Components/camera_modes_menu.dart';
import 'package:code/Utils/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(10.r),
        child: Column(
          children: [
            // Options
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.only(top: 10.r),
                child: Container(
                  decoration: BoxDecoration(
                      color: Palette.mainColor,
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: (40 * 2).r,
                          width: (40 * 2).r,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(5.r),
                              child: FaIcon(FontAwesomeIcons.xmark,
                                  color: Colors.white, size: 30.sp),
                            ),
                          ),
                        ),
                        Container(
                          height: (40 * 2).r,
                          width: (40 * 2).r,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(5.r),
                              child: FaIcon(FontAwesomeIcons.borderNone,
                                  color: Colors.white, size: 30.sp),
                            ),
                          ),
                        ),
                        Container(
                          height: (40 * 2).r,
                          width: (40 * 2).r,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(5.r),
                              child: FaIcon(FontAwesomeIcons.boltLightning,
                                  color: Colors.white, size: 30.sp),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            // Capture Frame
            Expanded(
              flex: 15,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.r),
                child: Placeholder(),
              ),
            ),
            // Action Modes
            const Expanded(
              flex: 2,
              child: CameraModes(
                options: ["Ordonnance", "Produit", "Code QR"],
              ),
            ),
            // Bottom Actions
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.only(top: 10.r),
                child: Container(
                  decoration: BoxDecoration(
                      color: Palette.mainColor,
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: (40 * 2).r,
                          width: (40 * 2).r,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5.r),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(9999),
                              child: Image.network(
                                "https://4.bp.blogspot.com/-YuY1AQ2n1Y4/VlSsI7ImDqI/AAAAAAAAAyU/TKcTYKrcDhA/s1600/motel%2B2000%2Bfront%2Bview.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9999.r),
                            ),
                            splashColor: Colors.black.withOpacity(0.1),
                            highlightColor: Colors.black.withOpacity(0.1),
                            focusColor: Colors.black.withOpacity(0.1),
                            onTap: () => print("Tap!"),
                            child: Ink(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(9999.r),
                              ),
                              child: SizedBox(
                                  height: (50 * 2).r, width: (50 * 2).r),
                            ),
                          ),
                        ),
                        Container(
                          height: (40 * 2).r,
                          width: (40 * 2).r,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(5.r),
                              child: FaIcon(FontAwesomeIcons.rotate,
                                  color: Colors.white, size: 30.sp),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
