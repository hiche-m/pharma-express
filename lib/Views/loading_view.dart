import 'package:code/Components/loading_indicator.dart';
import 'package:code/Provider/notifications_provider.dart';
import 'package:code/Provider/user_provider.dart';
import 'package:code/Utils/styling.dart';
import 'package:code/Views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({super.key});

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<NotificationsProvider>(
            create: (_) => NotificationsProvider()),
      ],
      child: Consumer2<UserProvider, NotificationsProvider>(
          builder: (context, userNotifier, notificationsNotifier, child) {
        userNotifier.fetchUser();
        if (userNotifier.currentUser != null) {
          notificationsNotifier.fetchNotifications("username123");
          return const Home();
        }
        return SafeArea(
            child: Container(
                color: Palette.mainColor,
                child: const Center(child: MyLoadingIndicator(type: 1))));
      }),
    );
  }
}
