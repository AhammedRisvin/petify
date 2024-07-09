// ignore_for_file: unused_element, deprecated_member_use

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  String? fcmToken;
  static final NotificationService ins = NotificationService._internal();
  factory NotificationService() {
    return ins;
  }
  NotificationService._internal();

  //------------------------------  Firebase Notification

  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initMessaging() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    fcmToken = await _firebaseMessaging.getToken();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.data}');
      if (message.notification != null) {
        debugPrint(
          'Message also contained a notification --: ${message.notification}',
        );
        String? image = message.notification!.android?.imageUrl;
        if (image != null) {
          showBigPictureNotification(
            title: message.notification!.title!,
            content: message.notification!.body!,
            url: image,
          );
        } else {
          debugPrint('Message also contained a notification --:');
          showSimpleNotification(
            title: message.notification!.title!,
            body: message.notification!.body!,
            payload: 'New Notification',
          );
        }
        // HiveImpl.ins.addNotification(
        //   NotificationModel(
        //     title: message.notification?.title ?? '',
        //     body: message.notification?.body ?? '',
        //     time: DateTime.now(),
        //   ),
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('A new onMessageOpenedApp event was published!');
      debugPrint('Message data: ${message.data}');
      if (message.notification != null) {
        debugPrint(
          'Message also : ${message.notification}',
        );
      }
    });

    // HiveImpl.ins.initHive();
  }

  Future<String?> getToken() async {
    try {
      return await _firebaseMessaging.getToken();
    } catch (e) {
      debugPrint("Error getting FCM token: $e");
      return null;
    }
  }

  Future<void> cancelFirebaseNotification(String token) async {
    try {
      await _firebaseMessaging.deleteToken();
    } catch (e) {
      debugPrint("Error deleting FCM token: $e");
    }
  }

  Future<void> subscribeToAllTopic() async {
    await _firebaseMessaging.subscribeToTopic('all');
  }

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeToTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  //--------------------------------  Local Notification ------------------------------  done

  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final onClickNotification = BehaviorSubject<String>();

// on tap on any notification
  static void onNotificationTap(NotificationResponse notificationResponse) {
    onClickNotification.add(notificationResponse.payload!);
  }

  static Future init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: onNotificationTap,
    );

    AndroidNotificationChannel defaultSound = const AndroidNotificationChannel(
      'event_channel',
      'Basic Notifications',
      description: 'This channel is used for event notifications',
      importance: Importance.max,
      sound: RawResourceAndroidNotificationSound('sound'),
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(defaultSound);
  }

  // show a simple notification
  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      playSound: true,
      enableVibration: true,
      enableLights: true,
      color: Colors.deepPurple[100],
      ledColor: Colors.deepPurple[100],
      ledOnMs: 1000,
      ledOffMs: 500,
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      attachments: [],
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      badgeNumber: 1,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    int notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    await _flutterLocalNotificationsPlugin.show(
      notificationId,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  // big picture style notification

  static Future<void> showBigPictureNotification({
    required String title,
    required String content,
    required String url,
  }) async {
    final bigPictureSt = await bigPicture(url: url);
    var bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPictureSt),
      hideExpandedLargeIcon: true,
      contentTitle: title,
      summaryText: content,
      largeIcon: FilePathAndroidBitmap(bigPictureSt),
    );
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'big_picture_channel',
      'Big Picture Notifications',
      styleInformation: bigPictureStyleInformation,
      largeIcon: FilePathAndroidBitmap(bigPictureSt),
    );
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails(
      attachments: [
        DarwinNotificationAttachment(
          bigPictureSt,
          identifier: 'big_picture',
          hideThumbnail: false,
        ),
      ],
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    int notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    await _flutterLocalNotificationsPlugin.show(
      notificationId,
      title,
      content,
      platformChannelSpecifics,
      payload: 'Big Picture Notification Payload',
    );
  }

  // close a specific channel notification
  static Future cancel(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  // close all the notifications available
  static Future cancelAll() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  static Future<String> bigPicture({required String url}) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/bigPicture.jpg';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final file = await File(filePath).writeAsBytes(response.bodyBytes);
        return file.path;
      } else {
        debugPrint(
            'Failed to fetch image. Status code: ${response.statusCode}');
        return '';
      }
    } catch (e) {
      debugPrint('Error fetching or writing image: $e');
      return '';
    }
  }

  Future<void> scheduleReminder({
    required DateTime eventDate,
  }) async {
    try {
      tz.initializeTimeZones();
      final tz.TZDateTime scheduledDate =
          tz.TZDateTime.from(eventDate, tz.local);
      int id = DateTime.now().millisecondsSinceEpoch % 2147483647;
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
        'event_channel',
        'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      );
      const NotificationDetails platformDetails = NotificationDetails(
        android: androidDetails,
      );

      // Schedule the notification
      await _flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        'Event Alert',
        'Event is about to start!',
        scheduledDate,
        platformDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: 'hotel_open',
      );
    } catch (e) {
      debugPrint('Error scheduling notification: $e');
    }
  }
}
