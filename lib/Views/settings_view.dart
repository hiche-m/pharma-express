import 'package:code/Utils/styling.dart';
import 'package:code/View%20Models/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(40.r, 40.r, 40.r, 60.r),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text("Profile", style: Palette.h1),
              ),
              SizedBox(height: 20.h),
              // Top Section
              Container(
                height: 100.h,
                decoration: BoxDecoration(
                  color: Palette.mainColor,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      spreadRadius: 2,
                      offset: Offset(2.w, 2.h),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9999),
                        border: Border.all(
                          color: Palette.superLight,
                          width: 2.0,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 40.r,
                        backgroundColor: Palette.placeholderGrey,
                        child: SvgPicture.asset("lib/Assets/Icons/Account.svg",
                            fit: BoxFit.contain),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nom Prénom",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp,
                            ),
                          ),
                          Text(
                            "email@domain.com",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              // Middle Section
              Container(
                decoration: BoxDecoration(
                  color: Palette.superLight,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      spreadRadius: 2,
                      offset: Offset(2.w, 2.h),
                      blurRadius: 5,
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Column(
                  children: [
                    for (int index = 0;
                        index < SettingsVM.settings.length;
                        index++)
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: ListTile(
                          leading: Padding(
                            padding: EdgeInsets.all(20.r),
                            child: SettingsVM.settings[index].icon,
                          ),
                          title: Text(
                            SettingsVM.settings[index].title,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                            ),
                          ),
                          subtitle: Text(
                            SettingsVM.settings[index].subtitle,
                            style: TextStyle(
                              color: Palette.secoundaryText,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                            ),
                          ),
                          trailing: SettingsVM.settings[index].tileKey !=
                                  "notif"
                              ? SettingsVM.settings[index].trailing ??
                                  FaIcon(
                                    FontAwesomeIcons.chevronRight,
                                    size: 20.r,
                                    color: Palette.secoundaryText,
                                  )
                              : Switch(
                                  value: SettingsVM.enableNotifications,
                                  activeColor: Palette.mainColor,
                                  onChanged: (value) {
                                    setState(() {
                                      SettingsVM.enableNotifications = value;
                                    });
                                  },
                                ),
                        ),
                      ),
                    // Log out
                    Opacity(
                      opacity: 0.75,
                      child: ListTile(
                        leading: Padding(
                          padding: EdgeInsets.all(20.r),
                          child: FaIcon(
                            FontAwesomeIcons.arrowRightFromBracket,
                            size: 25.r,
                            color: Palette.mainColor,
                          ),
                        ),
                        title: Text(
                          "Log Out",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                          ),
                        ),
                        subtitle: Text(
                          "Log out from this account.",
                          style: TextStyle(
                            color: Palette.secoundaryText,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                          ),
                        ),
                        trailing: FaIcon(
                          FontAwesomeIcons.chevronRight,
                          size: 20.r,
                          color: Palette.secoundaryText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              // Bottom Section
              Container(
                decoration: BoxDecoration(
                  color: Palette.superLight,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      spreadRadius: 2,
                      offset: Offset(2.w, 2.h),
                      blurRadius: 5,
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Column(
                  children: [
                    ListTile(
                      leading: Padding(
                        padding: EdgeInsets.all(20.r),
                        child: FaIcon(
                          FontAwesomeIcons.circleQuestion,
                          size: 25.r,
                          color: Palette.mainColor,
                        ),
                      ),
                      title: Text(
                        "Help & Support",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                        ),
                      ),
                      trailing: FaIcon(
                        FontAwesomeIcons.chevronRight,
                        size: 20.r,
                        color: Palette.secoundaryText,
                      ),
                    ),
                    ListTile(
                      leading: Padding(
                        padding: EdgeInsets.all(20.r),
                        child: FaIcon(
                          FontAwesomeIcons.heart,
                          size: 25.r,
                          color: Palette.mainColor,
                        ),
                      ),
                      title: Text(
                        "About the App",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                        ),
                      ),
                      trailing: FaIcon(
                        FontAwesomeIcons.chevronRight,
                        size: 20.r,
                        color: Palette.secoundaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
