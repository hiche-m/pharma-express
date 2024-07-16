import 'package:code/Components/navbar_icon.dart';
import 'package:code/Utils/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 75.h,
            width: 1.sw,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 7,
                    offset: const Offset(0, -7),
                  ),
                ],
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20.r))),
            child: Row(
              children: [
                // Home
                NavbarIcon(
                  path: "lib/Assets/Icons/Map.svg",
                  index: 0,
                  label: "Home",
                  selected: _selectedIndex,
                  onTap: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                ),
                NavbarIcon(
                  path: "lib/Assets/Icons/Notification.svg",
                  index: 1,
                  label: "Notifications",
                  selected: _selectedIndex,
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                ),
                const Spacer(),
                NavbarIcon(
                  path: "lib/Assets/Icons/Alarm.svg",
                  index: 2,
                  label: "Reminder",
                  selected: _selectedIndex,
                  onTap: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                ),
                NavbarIcon(
                  path: "lib/Assets/Icons/Account.svg",
                  index: 3,
                  label: "Settings",
                  selected: _selectedIndex,
                  onTap: () {
                    setState(() {
                      _selectedIndex = 3;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 25.h),
            child: Container(
              height: 80.h,
              width: 80.h,
              decoration: BoxDecoration(
                color: Palette.mainColor,
                borderRadius: BorderRadius.circular(9999),
                boxShadow: [
                  BoxShadow(
                    color: Palette.darkMain.withOpacity(0.05),
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: const Offset(2, 5),
                  )
                ],
              ),
              child: FractionallySizedBox(
                heightFactor: 0.35,
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    // Icon Path
                    "lib/Assets/Icons/Scan.svg",
                    semanticsLabel: "Action Button",
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
