import 'package:code/Components/loading_indicator.dart';
import 'package:code/Provider/cameras_provider.dart';
import 'package:code/Provider/notifications_provider.dart';
import 'package:code/Provider/user_provider.dart';
import 'package:code/Utils/styling.dart';
import 'package:code/Views/authentification_view.dart';
import 'package:code/Views/home_view.dart';
import 'package:flutter/foundation.dart';
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
    if (kIsWeb) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
          ChangeNotifierProvider<NotificationsProvider>(
              create: (_) => NotificationsProvider()),
        ],
        child: Consumer2<UserProvider, NotificationsProvider>(
            builder: (context, userNotifier, notificationsNotifier, child) {
          return FutureBuilder(
              future: userNotifier.isLoading ? userNotifier.fetchUser() : null,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SafeArea(
                      child: Container(
                          color: Palette.mainColor,
                          child: const Center(
                              child: MyLoadingIndicator(type: 1))));
                }

                if (userNotifier.currentUser == null) {
                  return const AuthView();
                }
                notificationsNotifier.fetchNotifications("username123");
                return const Home();
              });
        }),
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<NotificationsProvider>(
            create: (_) => NotificationsProvider()),
        ChangeNotifierProvider<CamerasProvider>(
            create: (_) => CamerasProvider()),
      ],
      child: Consumer3<UserProvider, NotificationsProvider, CamerasProvider>(
          builder: (context, userNotifier, notificationsNotifier,
              cameraNotifier, child) {
        List<Future<dynamic>> futures = [];
        if (userNotifier.isLoading) {
          futures.add(userNotifier.fetchUser());
        }
        if (cameraNotifier.loadingCameras == true) {
          futures.add(cameraNotifier.getCameras());
        }
        if (notificationsNotifier.loadingNotifications == true) {
          futures.add(notificationsNotifier.fetchNotifications("username123"));
        }

        return FutureBuilder(
            future: Future.wait(futures),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SafeArea(
                    child: Container(
                        color: Palette.mainColor,
                        child:
                            const Center(child: MyLoadingIndicator(type: 1))));
              }

              if (userNotifier.currentUser == null) {
                return const AuthView();
              }
              return const Home();
            });
      }),
    );
  }
}
