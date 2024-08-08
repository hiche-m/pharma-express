import 'package:code/Models/transaction_object.dart';
import 'package:code/Utils/styling.dart';
import 'package:code/Utils/text_formulations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationTile extends StatefulWidget {
  const NotificationTile({required this.transaction, super.key});

  final TransactionObj transaction;

  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  bool test = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75.h,
      width: 1.sw,
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16.sp,
                  height: 1.2,
                  color: Palette.textColor,
                ),
                children: [
                  TextSpan(
                      text:
                          "${AppLocalizations.of(context)!.confirmNotification} "),
                  if (widget.transaction.total != null)
                    TextSpan(
                      text:
                          "${AppLocalizations.of(context)!.totalNotification} ",
                    ),
                  if (widget.transaction.total != null)
                    TextSpan(
                      text:
                          "${widget.transaction.total!.toString()}${AppLocalizations.of(context)!.currency} ",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  TextSpan(
                    text:
                        "${AppLocalizations.of(context)!.sourceNotification} ",
                  ),
                  TextSpan(
                    text:
                        "${widget.transaction.source}${AppLocalizations.of(context)!.qstMark} ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: TextFM.formatDuration(
                        context,
                        DateTime.now()
                            .difference(widget.transaction.timestamp)),
                    style: TextStyle(
                      color: Palette.secoundaryText,
                      fontSize: 14.sp,
                    ),
                  ),
                  TextSpan(
                    text: '\n${widget.transaction.location}',
                    style: TextStyle(
                      color: Palette.secoundaryText,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              AnimatedScale(
                duration: const Duration(milliseconds: 250),
                scale: test ? 1 : 0,
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      test = false;
                    });
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Palette.secoundaryText,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5.w),
              Container(
                decoration: BoxDecoration(
                  color: Palette.mainColor,
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Confirm",
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white, // Text color
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
