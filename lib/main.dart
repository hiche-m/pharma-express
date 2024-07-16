import 'package:code/Views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Pharma Express',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const ScreenUtilInit(
        designSize: Size(492, 776),
        minTextAdapt: true,
        splitScreenMode: true,
        child: Home(),
      ),
    ),
  );
}
