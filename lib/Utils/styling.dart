import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Palette {
  static const Color backgroundColor = Color(0xFFF6F6F6);
  static const Color disabledColor = Color(0xFFD9D9D9);
  static const Color darkMain = Color(0xFF125E8A);
  static const Color mainColor = Color(0xFF4693C7);
  static const Color textColor = Color(0xFF050505);
  static const Color secoundaryText = Color(0xFF6C6C6C);
  static const Color selectionColor = Color(0xFFC2B8B2);
  static const Color selectionBackground = Color(0xFF8A716A);
  static const Color superLight = Color(0xFFFFFFFF);
  static const Color placeholderGrey = Color(0xFFBDBDBD);

  static const Duration lightAnimation = Duration(milliseconds: 50);
  static const Duration mediumAnimation = Duration(milliseconds: 150);
  static const Duration longAnimation = Duration(milliseconds: 300);

  static TextStyle h1 = TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w900);
  static TextStyle h2 = TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700);

  static TextTheme getDefaultTextTheme({Color color = textColor}) {
    return TextTheme(
      bodySmall: TextStyle(color: color),
      labelSmall: TextStyle(color: color),
      titleSmall: TextStyle(color: color),
      displaySmall: TextStyle(color: color),
      headlineSmall: TextStyle(color: color),
      bodyMedium: TextStyle(color: color),
      labelMedium: TextStyle(color: color),
      titleMedium: TextStyle(color: color),
      displayMedium: TextStyle(color: color),
      headlineMedium: TextStyle(color: color),
      bodyLarge: TextStyle(color: color),
      labelLarge: TextStyle(color: color),
      titleLarge: TextStyle(color: color),
      displayLarge: TextStyle(color: color),
      headlineLarge: TextStyle(color: color),
    );
  }
}
