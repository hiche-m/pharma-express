import 'package:code/Models/transaction_object.dart';
import 'package:code/Utils/fake_data.dart';
import 'package:flutter/material.dart';

class NotificationsProvider extends ChangeNotifier {
  List<TransactionObj>? notificationList;
  bool loadingNotifications = true;

  Future fetchNotifications(String uid) async {
    loadingNotifications = true;
    await Future.delayed(const Duration(seconds: 3));

    notificationList = FakeData.notifications;
    loadingNotifications = false;
    notifyListeners();
    return;
  }
}
