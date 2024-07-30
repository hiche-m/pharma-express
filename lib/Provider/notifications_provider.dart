import 'package:code/Models/transaction_object.dart';
import 'package:code/Utils/fake_data.dart';
import 'package:flutter/material.dart';

class NotificationsProvider extends ChangeNotifier {
  List<TransactionObj>? notificationList;

  void fetchNotifications(String uid) async {
    await Future.delayed(const Duration(seconds: 3));

    notificationList = FakeData.notifications;
    notifyListeners();
  }
}
