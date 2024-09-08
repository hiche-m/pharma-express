import 'package:code/Utils/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class DateInput extends StatefulWidget {
  const DateInput(
      {this.placeholder,
      this.title,
      this.initialValue,
      this.onChanged,
      this.dateFormat = 'dd/MM/yyyy',
      this.autoFocus = false,
      this.showBorder = true,
      super.key});

  final String? title;
  final String? placeholder;
  final String dateFormat;
  final void Function(DateTime?)? onChanged;
  final bool autoFocus;
  final String? initialValue;
  final bool showBorder;

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  bool _selected = false;
  String? error;
  DateTime? _pickedDate;
  late final DateFormat dateFormat;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    dateFormat = DateFormat(widget.dateFormat);
    _controller = TextEditingController();
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      try {
        _pickedDate = dateFormat.parse(widget.initialValue!);
        _controller.text = widget.initialValue!;
      } on Exception catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

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
                      color: error == null
                          ? _selected
                              ? Palette.mainColor
                              : Palette.disabledColor
                          : Colors.red,
                      width: _selected || error != null ? 1.5 : 1.0,
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
                    Expanded(
                      child: TextFormField(
                        autofocus: widget.autoFocus,
                        controller: _controller,
                        onChanged: (String? dateString) {
                          if (dateString != null && dateString.isNotEmpty) {
                            final date = dateFormat.parse(dateString);

                            if (dateString == dateFormat.format(date)) {
                              _pickedDate = date;
                              if (widget.onChanged != null) {
                                widget.onChanged!(_pickedDate);
                              }
                            }
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^[0-9/\- :.]*$')),
                          LengthLimitingTextInputFormatter(10),
                        ],
                        keyboardType: TextInputType.datetime,
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            setState(() {
                              error = 'This field is required.';
                            });
                            return '';
                          }
                          var parsedDate = dateFormat.parse(value);

                          if (value != dateFormat.format(parsedDate)) {
                            setState(() {
                              error =
                                  'Please enter a valid date. (Ex: 29/10/2001)';
                            });
                            return '';
                          }

                          setState(() {
                            error = null;
                          });
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5.w),
                      child: InkWell(
                        onTap: () async {
                          var pickedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null && pickedDate != _pickedDate) {
                            setState(() {
                              _pickedDate = pickedDate;
                              _controller.text = dateFormat.format(pickedDate);
                            });
                            if (widget.onChanged != null) {
                              widget.onChanged!(_pickedDate);
                            }
                          }
                        },
                        child: SizedBox(
                          height: 25.r,
                          width: 25.r,
                          child: const FittedBox(
                            fit: BoxFit.contain,
                            child: FaIcon(
                              FontAwesomeIcons.calendar,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          error != null ? SizedBox(height: 10.h) : const SizedBox(),
          error != null
              ? Text(
                  error!,
                  style: TextStyle(color: Colors.red, fontSize: 16.sp),
                )
              : const SizedBox(),
          /* SizedBox(height: 10.h), */
        ],
      ),
    );
  }
}
