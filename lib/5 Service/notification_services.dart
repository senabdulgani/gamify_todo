import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as timezone;

class NotificationServices {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static bool isNotificationsEnabled = true;

  Future<void> init() async {
    const InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );

    timezone.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<bool> requestNotificationPermissions() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  Future<void> showTaskCompletionNotification({
    required String taskTitle,
  }) async {
    if (!isNotificationsEnabled) return;

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      '🎉 Görev Tamamlandı!',
      '$taskTitle başarıyla tamamlandı!',
      notificationDetails(),
    );
  }

  Future<void> showStoreItemNotification({
    required String itemTitle,
  }) async {
    if (!isNotificationsEnabled) return;

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      '⚠️ Süre Doldu!',
      '$itemTitle süresi doldu!',
      notificationDetails(),
    );
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
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
