import 'package:code/Components/notification_tile.dart';
import 'package:code/Provider/notifications_provider.dart';
import 'package:code/Utils/styling.dart';
import 'package:code/View%20Models/notification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var provider = context.watch<NotificationsProvider>();
    if (provider.notificationList != null) {
      NotificationVM.loading = false;
      NotificationVM.notificationsList = provider.notificationList!;
      provider.removeListener(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (NotificationVM.loading) {
      return const Center(child: Text("Loading..."));
    }
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(40.w, 40.h, 40.w, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Notifications", style: Palette.h1),
                  FaIcon(FontAwesomeIcons.solidTrashCan,
                      color: Palette.textColor, size: 30.sp),
                ],
              ),
              SizedBox(height: 30.h),
              for (int i = 0; i < NotificationVM.notificationsList.length; i++)
                (i > 0 &&
                        NotificationVM.notificationsList[i].timestamp
                                .difference(NotificationVM
                                    .notificationsList[i - 1].timestamp)
                                .inDays >
                            1)
                    ? NotificationTile(
                        transaction: NotificationVM.notificationsList[i])
                    : Padding(
                        padding: EdgeInsets.only(top: 25.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat.yMMMMd().format(NotificationVM
                                  .notificationsList[i].timestamp),
                              style: TextStyle(
                                color: Palette.secoundaryText,
                                fontSize: 18.sp,
                              ),
                            ),
                            NotificationTile(
                                transaction:
                                    NotificationVM.notificationsList[i]),
                          ],
                        ),
                      ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
