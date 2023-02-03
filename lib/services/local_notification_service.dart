import 'package:flutter/cupertino.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"),
            iOS: DarwinInitializationSettings(
                requestSoundPermission: false,
                requestBadgePermission: false,
                requestAlertPermission: false));
    _notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  static BuildContext? context;
  static void onDidReceiveNotificationResponse(NotificationResponse? response) {
    if (response != null && response.payload != null) {
      Navigator.of(context!).pushNamed(response.payload.toString());
      print(response.payload);
    }
  }

  static Future<void> display(
      {required String title,
      required String body,
      String? payload,
      BuildContext? buildContext,
      String? image,
      String? logo}) async {
    if (buildContext != null) {
      context = buildContext;
    }
  }
}
