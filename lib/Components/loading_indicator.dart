import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyLoadingIndicator extends StatefulWidget {
  /// Custom Loading Indicator made for Pharma Express.
  ///
  ///
  /// [int] type: Can contain 3 values:
  ///
  ///
  /// 0: Blue outlined icon.
  ///
  /// 1: White outlined icon.
  ///
  /// 2: Blue and white glass icon.

  const MyLoadingIndicator({this.type = 0, super.key});
  final int type;
  @override
  State<MyLoadingIndicator> createState() => _MyLoadingIndicatorState();
}

class _MyLoadingIndicatorState extends State<MyLoadingIndicator>
    with SingleTickerProviderStateMixin {
  final _rotateTween = Tween<double>(begin: 0, end: 0.5);

  late AnimationController _controller;
  late Animation<double> _angleAnimation;
  late String path;

  double size = 60.h;

  @override
  void initState() {
    super.initState();
    if (widget.type == 0) {
      path = 'lib/Assets/Icons/Pill.svg';
    } else if (widget.type == 1) {
      path = 'lib/Assets/Icons/White_pill.svg';
    } else if (widget.type == 2) {
      path = 'lib/Assets/Icons/Glass_Pill.svg';
      size = 75.h;
    } else {
      throw Exception([
        "Loading Indicator: Undefined type/Path not found.\n\nIndicator type must be an integer (0, 1, 2)\n\nFollowing paths must exist:\n'lib/Assets/Icons/Pill.svg'\n'lib/Assets/Icons/White_pill.svg'\n'lib/Assets/Icons/Glass_Pill.svg'"
      ]);
    }

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _angleAnimation = _rotateTween.animate(_controller);
    startAnimationLoop();
  }

  void startAnimationLoop() {
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: _angleAnimation,
        child: SizedBox(
          height: size,
          width: size,
          child: FittedBox(
            fit: BoxFit.contain,
            child: SvgPicture.asset(
              // Icon Path
              path,
              semanticsLabel: 'Loading...',
            ),
          ),
        ),
      ),
    );
  }
}
