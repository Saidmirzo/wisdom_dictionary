import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class LocalNotificationService {
  final AwesomeNotifications awesomeNotifications = AwesomeNotifications();
  Future<bool> createNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    return awesomeNotifications.createNotification(
      content: NotificationContent(
        id: id,
        channelKey: "channelKey",
        groupKey: "channelGroupKey",
        title: title,
        body: body,
      ),
    );
  }
  
  Future<bool> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required TimeOfDay time,
  }) async {
    await awesomeNotifications.cancelAll();
    return awesomeNotifications.createNotification(
      content: NotificationContent(
        id: id,
        channelKey: "channelKey",
        groupKey: "channelGroupKey",
        title: title,
        body: body,
      ),
      schedule: NotificationCalendar(
        hour: time.hour,
        minute: time.minute,
        second: 0,
        repeats: true,
      ),
    );
  }

  Future<void> cancelAll() async {
    await awesomeNotifications.cancelAll();
  }
}
