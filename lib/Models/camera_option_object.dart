import 'package:flutter/material.dart';

class CameraOption {
  final Widget icon;
  final void Function()? onTap;
  final Color highlightColor;
  final bool disabled;

  CameraOption(
      {required this.icon,
      this.onTap,
      this.highlightColor = Colors.yellow,
      this.disabled = false});

  CameraOption.fromMap(Map<String, dynamic> map)
      : icon = map["icon"],
        onTap = map["onTap"],
        highlightColor = map["highlightColor"] ?? Colors.yellow,
        disabled = map["disabled"] ?? false;
}
