import 'dart:math';

import 'package:flutter/material.dart';

class CameraGrid extends StatelessWidget {
  const CameraGrid({
    this.size = 9,
    this.color = Colors.black,
    this.width = 1,
    super.key,
  });

  final double size;
  final Color color;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      children: [
        for (int i = 0; i < sqrt(size); i++)
          Expanded(
            child: Column(
              children: [
                for (int j = 0; j < sqrt(size); j++)
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: color, width: width)),
                    ),
                  ),
              ],
            ),
          ),
      ],
    ));
  }
}
