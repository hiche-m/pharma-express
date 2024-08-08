import 'package:code/Models/camera_option_object.dart';
import 'package:code/Utils/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CameraOptions extends StatefulWidget {
  const CameraOptions(
      {required this.optionIcons, this.disabled = false, super.key});

  final List<CameraOption> optionIcons;
  final bool disabled;

  @override
  State<CameraOptions> createState() => _CameraOptionsState();
}

class _CameraOptionsState extends State<CameraOptions> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
            color: widget.disabled
                ? Palette.mainColor.withAlpha(50)
                : Palette.mainColor,
            borderRadius: BorderRadius.circular(15.r)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (int index = 0; index < widget.optionIcons.length; index++)
                IgnorePointer(
                  ignoring: widget.optionIcons[index].disabled,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: widget.optionIcons[index].onTap,
                      splashColor: Colors.black.withOpacity(0.1),
                      highlightColor: Colors.black.withOpacity(0.1),
                      focusColor: Colors.black.withOpacity(0.1),
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9999.r),
                      ),
                      child: Ink(
                        height: (40 * 2).r,
                        width: (40 * 2).r,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: FractionallySizedBox(
                          heightFactor: 0.5,
                          alignment: Alignment.center,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                widget.optionIcons[index].highlightColor,
                                BlendMode.srcATop,
                              ),
                              child: widget.optionIcons[index].icon,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ]),
      ),
    );
  }
}
