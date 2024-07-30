import 'package:code/Components/navigation_bar.dart';
import 'package:code/Utils/styling.dart';
import 'package:code/View%20Models/home_view_model.dart';
import 'package:code/Views/camera_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void loadScreen() async {
    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const CameraView(),
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 75.h),
              child: PageView.builder(
                  itemCount: HomeVM.pagesList.length,
                  controller: HomeVM.pageController,
                  onPageChanged: (value) => setState(() {
                        HomeVM.pageIndex = value;
                      }),
                  itemBuilder: (context, index) {
                    return HomeVM.pagesList[index];
                  }),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomNavigationBar(
                  selectedIndex: HomeVM.pageIndex,
                  animateToPage: HomeVM.animateToPage),
            ),
          ],
        ),
      ),
    );
  }
}
