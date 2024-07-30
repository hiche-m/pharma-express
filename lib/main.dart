import 'package:code/Utils/styling.dart';
import 'package:code/Views/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Pharma Express',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar'),
        Locale('fr'),
        Locale('en'),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Palette.mainColor),
        useMaterial3: true,
        /* fontFamily: "Zain", */
      ),
      debugShowCheckedModeBanner: false,
      home: const ScreenUtilInit(
        designSize: Size(492, 776),
        minTextAdapt: true,
        splitScreenMode: true,
        child: LoadingView(),
      ),
    ),
  );
}
