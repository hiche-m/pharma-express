import 'package:code/Components/navigation_bar.dart';
import 'package:code/Utils/styling.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: CustomNavigationBar(),
      ),
    );
  }
}
