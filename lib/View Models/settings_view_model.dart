import 'package:code/Utils/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsVM {
  static bool enableNotifications = true;

  static List<SettingTile> settings = [
    SettingTile.fromMap({
      "title": "History",
      "subtitle": "Access your buying history.",
      "icon": FaIcon(
        FontAwesomeIcons.clockRotateLeft,
        size: 25.r,
        color: Palette.mainColor,
      ),
    }),
    SettingTile.fromMap({
      "title": "My Account",
      "subtitle": "Make changes to your account.",
      "icon": FaIcon(
        FontAwesomeIcons.user,
        size: 25.r,
        color: Palette.mainColor,
      ),
      "trailing": SizedBox(
        width: (20.r) * 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FaIcon(
              FontAwesomeIcons.triangleExclamation,
              size: 20.r,
              color: Colors.red,
            ),
            FaIcon(
              FontAwesomeIcons.chevronRight,
              size: 20.r,
              color: Palette.secoundaryText,
            ),
          ],
        ),
      ),
    }),
    SettingTile.fromMap({
      "title": "Notifications",
      "subtitle": "Toggle phone notifications.",
      "icon": FaIcon(
        FontAwesomeIcons.bell,
        size: 25.r,
        color: Palette.mainColor,
      ),
      "tileKey": "notif",
    }),
    SettingTile.fromMap({
      "title": "Security",
      "subtitle": "Manage your account security.",
      "icon": FaIcon(
        FontAwesomeIcons.fingerprint,
        size: 25.r,
        color: Palette.mainColor,
      ),
    }),
    SettingTile.fromMap({
      "title": "Two-Factor Authentication",
      "subtitle": "Further secure your account for safety.",
      "icon": FaIcon(
        FontAwesomeIcons.shieldHalved,
        size: 25.r,
        color: Palette.mainColor,
      ),
    }),
  ];
}

class SettingTile {
  SettingTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.trailing,
    this.tileKey,
  });

  SettingTile.fromMap(Map<String, dynamic> map)
      : title = map["title"],
        subtitle = map["subtitle"],
        icon = map["icon"],
        trailing = map["trailing"],
        tileKey = map["tileKey"];

  final String title;
  final String subtitle;
  final Widget icon;
  final Widget? trailing;
  final String? tileKey;
}
