import 'package:code/Utils/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainInput extends StatefulWidget {
  /// [StatefulWidget] MainInput: Pharma Express main input component, it basically is a [TextFormField] designed
  /// specifically to meet the needs of the Pharma Express app.
  const MainInput(
      {this.title,
      this.placeholder,
      this.initialValue,
      this.error,
      this.validator,
      this.leadingIcon,
      this.leadingAction,
      this.tailingIcon,
      this.tailingAction,
      this.onChanged,
      this.inputFormatters,
      this.keyboardType,
      this.autoFocus = false,
      this.obscure = false,
      this.showBorder = true,
      super.key});

  /// [String] title: Equivalent to a label in html, when set a title will appear above the [TextFormField].
  final String? title;

  /// [String] placeholder: When set, a hint text is set inside the [TextFormField].
  final String? placeholder;

  /// [String] initialValue: When set, a [String] value is filled inside the [TextFormField] initially.
  final String? initialValue;

  /// [String] error: When set, a red error message would appear below the [TextFormField].
  final String? error;

  /// [String] [Function]([String]) validator: The validator for the [TextFormField],
  /// triggers when the component is a descendant of a form widget that has been validated.
  final String? Function(String?)? validator;

  /// [bool] autoFocus: When set to true, the [TextFormField] will automatically be focused on (Selected) when
  /// the page loads initially.
  ///
  /// WARNING: Do not set multiple components autoFocus to true, it may not focus properly.
  final bool autoFocus;

  /// [bool] obscure: When set to true, the value inside the [TextFormField] is hidden.
  ///
  ///
  /// Example:
  ///
  /// (Obscure = false): Password = 12345678
  ///
  /// (Obscure = true): Password = ********
  final bool obscure;

  /// When set to true, the MainInput widget will have a border.
  ///
  /// This includes error/selection outlines.
  final bool showBorder;

  /// [Widget] leadingIcon: When set, a leading icon/widget will appear before the text of the [TextFormField].
  final Widget? leadingIcon;

  /// [VoidCallback] leadingAction: When set, the leading icon/widget provided will trigger this function when tapped.
  final VoidCallback? leadingAction;

  /// [Widget] tailingIcon: When set, a tailing icon/widget will appear after the text of the [TextFormField].
  final Widget? tailingIcon;

  /// [VoidCallback] leadingAction: When set, the tailing icon/widget provided will trigger this function when tapped.
  final VoidCallback? tailingAction;

  /// [void] [Function]([String]) onChanged: The onChanged function for the [TextFormField],
  /// triggers whenever there's change to the [TextFormField] input value.
  final void Function(String?)? onChanged;

  /// [List]<[TextInputFormatter]> inputFormatters: When set, the patterns can for example determine which characters the [TextFormField] values
  /// can contain and which not to, along with other possible formats...
  final List<TextInputFormatter>? inputFormatters;

  /// [TextInputType] keyboardType: When set, it controlls which keyboard type to show for this [TextFormField].
  final TextInputType? keyboardType;

  /// Create a new [MainInput] instance by providing a [Map] directly without having to name every parameter needed.
  ///
  ///
  ///
  /// Parameters available:
  ///
  ///
  /// * [String] title
  ///
  /// * [String] placeholder
  ///
  /// * [String] initialValue
  ///
  /// * [String] error
  ///
  /// * [String] [Function]([String]) validator
  ///
  /// * [Widget] leadingIcon
  ///
  /// * [VoidCallback] leadingAction
  ///
  /// * [Widget] tailingIcon
  ///
  /// * [VoidCallback] tailingAction
  ///
  /// * [void] [Function]([String]) onChanged
  ///
  /// * [bool] autoFocus
  ///
  /// * [bool] obscure
  ///
  /// * [List]<[TextInputFormatter]> inputFormatters
  ///
  ///
  /// Note: All parameters are optional.
  MainInput.fromMap(Map map, {super.key})
      : title = map["title"],
        placeholder = map["placeholder"],
        initialValue = map["initialValue"],
        error = map["error"],
        validator = map["validator"],
        leadingIcon = map["leadingIcon"],
        leadingAction = map["leadingAction"],
        tailingIcon = map["tailingIcon"],
        tailingAction = map["tailingAction"],
        onChanged = map["onChanged"],
        inputFormatters = map["inputFormatters"],
        keyboardType = map["keyboardType"],
        autoFocus = map["autoFocus"] ?? false,
        showBorder = map["showBorder"] ?? true,
        obscure = map["obscure"] ?? false;

  @override
  State<MainInput> createState() => _MainInputState();
}

class _MainInputState extends State<MainInput> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: 1.sw,
      duration: const Duration(milliseconds: 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title != null
              ? Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Text(
                    widget.title!,
                    style: Palette.h2,
                  ),
                )
              : const SizedBox(),
          Container(
            decoration: BoxDecoration(
              color: Palette.backgroundColor,
              border: widget.showBorder
                  ? Border.all(
                      color: widget.error == null
                          ? _selected
                              ? Palette.mainColor
                              : Palette.disabledColor
                          : Colors.red,
                      width: _selected || widget.error != null ? 1.5 : 1.0,
                    )
                  : null,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Focus(
              onFocusChange: (value) {
                setState(() {
                  _selected = value;
                });
              },
              child: SizedBox(
                height: 45.h,
                child: Row(
                  children: [
                    if (widget.leadingIcon != null)
                      Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: InkWell(
                          onTap: widget.leadingAction,
                          child: SizedBox(
                            height: 25.r,
                            width: 25.r,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: widget.leadingIcon,
                            ),
                          ),
                        ),
                      ),
                    Expanded(
                      child: TextFormField(
                        autofocus: widget.autoFocus,
                        initialValue: widget.initialValue,
                        obscureText: widget.obscure,
                        onChanged: widget.onChanged,
                        inputFormatters: widget.inputFormatters,
                        keyboardType: widget.keyboardType,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(10.w, 15.h, 0, 15.h),
                          hintText: widget.placeholder,
                          hintStyle: TextStyle(
                            color: Palette.placeholderGrey,
                            fontSize: 16.sp,
                          ),
                          errorStyle: const TextStyle(height: 0, fontSize: 0),
                          errorMaxLines: 1,
                        ),
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                        validator: widget.validator,
                      ),
                    ),
                    if (widget.tailingIcon != null)
                      Padding(
                        padding: EdgeInsets.only(right: 5.w),
                        child: InkWell(
                          onTap: widget.tailingAction,
                          child: SizedBox(
                            height: 25.r,
                            width: 25.r,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: widget.tailingIcon,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          widget.error != null ? SizedBox(height: 10.h) : const SizedBox(),
          widget.error != null
              ? Text(
                  widget.error!,
                  style: TextStyle(color: Colors.red, fontSize: 16.sp),
                )
              : const SizedBox(),
          /* SizedBox(height: 10.h), */
        ],
      ),
    );
  }
}
