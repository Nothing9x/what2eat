import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initialize() async {
    tz.initializeTimeZones();
    try {
      final timeZoneInfo = await FlutterTimezone.getLocalTimezone();
      debugPrint('NotificationService: Local timezone is ${timeZoneInfo.identifier}');
      tz.setLocalLocation(tz.getLocation(timeZoneInfo.identifier));
    } catch (e) {
      // Fallback to UTC or a default if getting local timezone fails
      tz.setLocalLocation(tz.getLocation('UTC'));
      debugPrint('NotificationService: Error getting local timezone: $e');
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) async {
        debugPrint('NotificationService: Notification tapped: ${details.payload}');
      },
    );
    debugPrint('NotificationService: Initialized successfully');
  }

  Future<void> requestPermissions() async {
    final iosResult = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    debugPrint('NotificationService: iOS permission result: $iosResult');
    
    final androidPlugin = flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    
    if (androidPlugin != null) {
      final notificationPermission = await androidPlugin.requestNotificationsPermission();
      debugPrint('NotificationService: Android notification permission: $notificationPermission');
      
      final exactAlarmPermission = await androidPlugin.requestExactAlarmsPermission();
      debugPrint('NotificationService: Android exact alarm permission: $exactAlarmPermission');
      
      // Check if exact alarms are permitted
      final canScheduleExact = await androidPlugin.canScheduleExactNotifications();
      debugPrint('NotificationService: Can schedule exact notifications: $canScheduleExact');
    }
  }

  /// Show a test notification immediately to verify notifications work
  Future<void> showTestNotification() async {
    debugPrint('NotificationService: Showing test notification');
    await flutterLocalNotificationsPlugin.show(
      0,
      'Test Notification',
      'This is a test notification from What2Eat!',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'test_channel',
          'Test Notifications',
          channelDescription: 'Test notification channel',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
    debugPrint('NotificationService: Test notification shown');
  }

  /// Schedule a one-time notification at the specified time
  /// If the time has already passed today, it will be scheduled for tomorrow
  Future<void> scheduleOneTimeNotification({
    required int id,
    required String title,
    required String body,
    required TimeOfDay time,
  }) async {
    final scheduledTime = _nextInstanceOfTime(time);
    debugPrint('NotificationService: Scheduling one-time notification at $scheduledTime (id: $id)');
    
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'onetime_notification_channel',
          'One-time Notifications',
          channelDescription: 'One-time notification for food categories',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      // No matchDateTimeComponents means it's a one-time notification
    );
    debugPrint('NotificationService: One-time notification scheduled successfully');
  }

  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required TimeOfDay time,
  }) async {
    final scheduledTime = _nextInstanceOfTime(time);
    debugPrint('NotificationService: Scheduling daily notification at $scheduledTime (id: $id)');
    
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_notification_channel',
          'Daily Notifications',
          channelDescription: 'Daily notification for food categories',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    debugPrint('NotificationService: Daily notification scheduled successfully');
  }

  Future<void> scheduleWeeklyNotification({
    required int id,
    required String title,
    required String body,
    required TimeOfDay time,
    required List<int> weekdays,
  }) async {
    debugPrint('NotificationService: Scheduling weekly notification');
    debugPrint('NotificationService: Time: ${time.hour}:${time.minute}, Days: $weekdays');
    
    for (final day in weekdays) {
      // day is 1 (Monday) to 7 (Sunday)
      final scheduledTime = _nextInstanceOfTimeAndDay(time, day);
      debugPrint('NotificationService: Scheduling for day $day at $scheduledTime (id: ${id + day})');
      
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id + day, // Unique ID per day
        title,
        body,
        scheduledTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'weekly_notification_channel',
            'Weekly Notifications',
            channelDescription: 'Weekly notification for food categories',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
      debugPrint('NotificationService: Scheduled notification for day $day successfully');
    }
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
  
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  /// Get list of pending notifications for debugging
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    final pending = await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    debugPrint('NotificationService: ${pending.length} pending notifications');
    for (final notification in pending) {
      debugPrint('  - ID: ${notification.id}, Title: ${notification.title}');
    }
    return pending;
  }

  tz.TZDateTime _nextInstanceOfTime(TimeOfDay time) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    debugPrint('NotificationService: Next instance of ${time.hour}:${time.minute} is $scheduledDate');
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfTimeAndDay(TimeOfDay time, int day) {
    tz.TZDateTime scheduledDate = _nextInstanceOfTime(time);
    while (scheduledDate.weekday != day) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    debugPrint('NotificationService: Next instance of ${time.hour}:${time.minute} on day $day is $scheduledDate');
    return scheduledDate;
  }
}
