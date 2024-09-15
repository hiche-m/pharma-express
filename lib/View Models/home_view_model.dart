import 'package:code/Views/map_view.dart';
import 'package:code/Views/notification_view.dart';
import 'package:code/Views/reminder_view.dart';
import 'package:code/Views/settings_view.dart';
import 'package:flutter/material.dart';

class HomeVM {
  static final List<Widget> pagesList = [
    const MapView(),
    const NotificationView(),
    const ReminderView(),
    const SettingsView(),
  ];

  static int pageIndex = 0;

  static final pageController = PageController(initialPage: 0);

  static void animateToPage(int index, int selected) {
    if ((selected - index).abs() == 1) {
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else if ((selected - index).abs() > 1) {
      pageController.jumpToPage(index);
    }
  }
}
