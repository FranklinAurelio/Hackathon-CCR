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

  static AndroidNotificationChannel get _androidChannel =>
      const AndroidNotificationChannel(
        'channel_notification',
        'Notificações',
        'Notificações',
        enableLights: true,
        enableVibration: true,
        importance: Importance.Max,
        playSound: true,
        showBadge: true,
      );

  static AndroidNotificationDetails get _androidDetails =>
      const AndroidNotificationDetails(
        'channel_notification',
        'Notificações',
        'Notificações',
        enableLights: true,
        enableVibration: true,
        importance: Importance.Max,
        playSound: true,
        channelShowBadge: true,
      );

  static IOSNotificationDetails get _iosDetails => const IOSNotificationDetails(
        presentSound: true,
        presentBadge: true,
      );

  static Future<void> registerPeriodicallyHourlyShow(
      {String title, String body}) async {
    try {
      final platformChannelSpecifics =
          NotificationDetails(_androidDetails, _iosDetails);
      await _plugin.periodicallyShow(
        0,
        title,
        body,
        RepeatInterval.Hourly,
        platformChannelSpecifics,
      );
    } catch (e, str) {
      if (kDebugMode) {
        print('Error caught: $e');
        print(str);
      }
    }
  }

  static Future<void> init({
    _ReceivedNotificationCallback receivedNotificationCallback,
    _SelectedNotificationCallback selectedNotificationCallback,
  }) async {
    try {
      final androidSettings = AndroidInitializationSettings('ic_launcher');
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
      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_androidChannel);
    } catch (e, str) {
      if (kDebugMode) {
        print('Error caught: $e');
        print(str);
      }
    }
  }
}
