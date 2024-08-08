import 'package:code/Utils/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainInputButton extends StatelessWidget {
  const MainInputButton({
    required this.label,
    required this.onPressed,
    this.backgroundColor = Palette.mainColor,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      width: 1.sw,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          overlayColor:
              MaterialStateProperty.all<Color>(Colors.black.withOpacity(0.1)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Palette.superLight,
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }
}
