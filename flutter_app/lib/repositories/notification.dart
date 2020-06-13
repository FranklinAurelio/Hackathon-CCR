import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutterapp/Models/received_notification.dart';

typedef _ReceivedNotificationCallback = void Function(
    ReceivedNotification notification);
typedef _SelectedNotificationCallback = void Function(String payload);

class NotificationRepository {
  NotificationRepository._internal();

  static FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init({
    _ReceivedNotificationCallback receivedNotificationCallback,
    _SelectedNotificationCallback selectedNotificationCallback,
  }) async {
    try {
      final androidSettings = AndroidInitializationSettings('app_icon');
      final iosSettings = IOSInitializationSettings(
          onDidReceiveLocalNotification: (id, title, body, payload) async {
        receivedNotificationCallback(ReceivedNotification(
          id: id,
          title: title,
          body: body,
          payload: payload,
        ));
      });
      final initSettings = InitializationSettings(androidSettings, iosSettings);
      await _plugin.initialize(
        initSettings,
        onSelectNotification: selectedNotificationCallback,
      );
      final androidNotificationChannel = AndroidNotificationChannel(
        'channel_notification',
        'Notificações',
        'Notificações',
        enableLights: true,
        enableVibration: true,
        importance: Importance.Max,
        playSound: true,
        showBadge: true,
      );
      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(androidNotificationChannel);
    } catch (e, str) {
      if (kDebugMode) {
        print('Error caught: $e');
        print(str);
      }
    }
  }
}
