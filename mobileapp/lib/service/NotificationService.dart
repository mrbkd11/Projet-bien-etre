// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static void initNotification() async {
//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//       iOS: IOSInitializationSettings(
//           requestAlertPermission: true,
//           requestBadgePermission: true,
//           requestSoundPermission: true,
//           onDidReceiveLocalNotification: onDidReceiveLocalNotification),
//     );

//     await _notificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
//   }

//   static Future<void> showNotification({
//     required int id,
//     required String title,
//     required String body,
//   }) async {
//     const NotificationDetails notificationDetails = NotificationDetails(
//       android: AndroidNotificationDetails(
//         'channelId',
//         'channelName',
//         channelDescription: 'channelDescription',
//         importance: Importance.max,
//         priority: Priority.high,
//       ),
//       iOS: IOSNotificationDetails(),
//     );

//     await _notificationsPlugin.show(id, title, body, notificationDetails);
//   }

//   static Future onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) async {
//     // Handle receiving local notification
//   }

//   static void onDidReceiveNotificationResponse(
//       NotificationResponse notificationResponse) {
//     // Handle notification tap
//   }
// }
