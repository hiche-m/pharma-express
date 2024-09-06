import 'package:code/Components/reminder_dialog.dart';
import 'package:flutter/material.dart';

class ReminderVM {
  static const String cycleNames = "Avant Repas;Après Repas;A jeun";

  static Future showReminderDialog(BuildContext context) {
    return showDialog(
        context: context, builder: (context) => const ReminderDialog());
  }
}
