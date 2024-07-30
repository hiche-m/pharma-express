import 'package:code/Utils/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavbarIcon extends StatefulWidget {
  const NavbarIcon(
      {required this.path,
      required this.index,
      required this.selected,
      this.onTap,
      this.label,
      super.key});
  final String path;
  final int index;
  final int selected;
  final String? label;
  final void Function()? onTap;
  @override
  State<NavbarIcon> createState() => _NavbarIconState();
}

class _NavbarIconState extends State<NavbarIcon> {
  bool highlight = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            highlight = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            highlight = false;
          });
        },
        onTap: widget.onTap,
        child: Container(
          color: highlight ? Colors.black.withOpacity(0.025) : null,
          child: FractionallySizedBox(
            heightFactor: 0.35,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: widget.index == widget.selected
                          ? Palette.darkMain.withOpacity(0.05)
                          : Colors.transparent,
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: const Offset(2, 5),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      // Icon Path
                      widget.path,
                      semanticsLabel: widget.label,
                      colorFilter: ColorFilter.mode(
                        Palette.disabledColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: widget.index == widget.selected ? 1 : 0,
                      duration: Palette.mediumAnimation,
                      child: SvgPicture.asset(
                        // Icon Path
                        widget.path,
                        semanticsLabel: widget.label,
                        colorFilter: ColorFilter.mode(
                          Palette.darkMain,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
