import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();

    const InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<bool> checkNotificationPermissions() async {
    final status = await Permission.notification.request();

    return status.isGranted;
  }

  Future<bool> checkAlarmPermission() async {
    final status = Permission.scheduleExactAlarm.request();

    return status.isGranted;
  }

  // Future<void> showTaskCompletionNotification({
  //   required String taskTitle,
  // }) async {
  //   await flutterLocalNotificationsPlugin.show(
  //     DateTime.now().millisecondsSinceEpoch.remainder(100000),
  //     '🎉 Görev Tamamlandı!',
  //     '$taskTitle başarıyla tamamlandı!',
  //     notificationDetails(),
  //   );
  // }

  // scheduledNotification
  Future<void> scheduleNotification({
    required int id,
    required String desc,
    required String title,
    required DateTime scheduledDate,
    required bool isAlarm,
  }) async {
    final tz.TZDateTime scheduledTZDate = tz.TZDateTime.from(
      scheduledDate,
      tz.local,
    );

    if (isAlarm) {
      // TODO:
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        desc,
        scheduledTZDate,
        notificationDetails(),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } else {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        desc,
        scheduledTZDate,
        notificationDetails(),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  Future<void> notificaitonTest() async {
    final tz.TZDateTime scheduledDate = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 1));

    await flutterLocalNotificationsPlugin.zonedSchedule(
      21232,
      "test",
      "test test test",
      scheduledDate,
      notificationDetails(),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'task_completion',
        'Task Completion',
        channelDescription: 'Notifications for completed tasks',
        importance: Importance.max,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      ),
    );
  }
}
