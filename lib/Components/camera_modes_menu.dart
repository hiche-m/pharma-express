import 'package:code/Utils/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CameraModes extends StatefulWidget {
  /// CameraModes: A menu made for the Pharma Express's app camera screen/view, used to switch between modes.
  ///
  /// Example: QRCode | Barcode | Perscription
  const CameraModes(
      {required this.options,
      this.initialSelection = 0,
      this.onChanged,
      this.disabled = false,
      super.key});

  /// [List][String] options: List of String names for every mode label in the menu.
  final List<String> options;

  /// [int] initialSelection: The index of the mode selected when the widget loads.
  final int initialSelection;

  /// [ValueChanged][int] onChanged: Returns the index value of the selected mode.
  final ValueChanged<int>? onChanged;

  /// [bool] disabled: When this is true, the color would grey out.
  final bool disabled;

  @override
  State<CameraModes> createState() => _CameraModesState();
}

class _CameraModesState extends State<CameraModes> {
  late int _selection;

  @override
  void initState() {
    super.initState();
    _selection = widget.initialSelection;
  }

  void _changeSelection(int index) {
    if (widget.onChanged != null) {
      widget.onChanged!(index);
    }
    setState(() {
      _selection = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        color: widget.disabled
            ? Palette.selectionColor.withAlpha(50)
            : Palette.selectionColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < widget.options.length; i++)
            InkWell(
              onTap: () {
                _changeSelection(i);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: _selection == i
                      ? Colors.black.withOpacity(0.15)
                      : Colors.black.withOpacity(0),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.r),
                  child: Text(
                    widget.options[i],
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight:
                          _selection == i ? FontWeight.bold : FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
