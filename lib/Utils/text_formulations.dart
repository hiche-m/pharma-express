import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TextFM {
  static String formatDuration(BuildContext context, Duration duration) {
    if (duration.inDays > 6) {
      return "${duration.inDays ~/ 7} ${AppLocalizations.of(context)!.weekUnit}";
    }

    if (duration.inHours > 23) {
      return "${duration.inDays} ${AppLocalizations.of(context)!.dayUnit}";
    }

    if (duration.inMinutes > 59) {
      return "${duration.inHours} ${AppLocalizations.of(context)!.hourUnit}";
    }

    return "${duration.inMinutes} ${AppLocalizations.of(context)!.minuteUnit}";
  }

  /// Fix name spaces and first letter capitals.
  static String capFix(String text) {
    String s, newText;
    text = "$text ";
    while (text[0] == ' ') {
      text = text.substring(1);
    }
    try {
      s = _fixSpaces(text.substring(text.indexOf(" ")));
    } catch (e) {
      s = "";
    }
    newText = _capFixWord(text.substring(0, text.indexOf(" ")), true);

    while (true) {
      try {
        String word = _capFixWord(
            s.substring(s.indexOf(" "), s.indexOf(" ", s.indexOf(" ") + 1)),
            false);
        newText = newText + _fixSpaces(word);
        s = _fixSpaces(
            s.substring(s.indexOf(" ", s.indexOf(" ") + 1), s.length));
      } catch (e) {
        break;
      }
    }
    return newText;
  }

  static String _capFixWord(String text, bool firstMode) {
    return firstMode
        ? text.substring(0, 1).toUpperCase() + text.substring(1).toLowerCase()
        : text.substring(0, text.indexOf(" ") + 2).toUpperCase() +
            text.substring(text.indexOf(" ") + 2).toLowerCase();
  }

  static String _fixSpaces(String text) {
    while (text[text.indexOf(" ") + 1] == " ") {
      text = text.substring(0, text.indexOf(" ")) +
          text.substring(text.indexOf(" ") + 1);
    }

    return text;
  }

  static String nWordWithNoSpaces(String text, int n) {
    text += " ";
    text = text.split(" ")[n];

    return text;
  }
}
