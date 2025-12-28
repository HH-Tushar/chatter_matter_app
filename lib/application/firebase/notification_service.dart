import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../env.dart';

class NotificationService {
  // final NotificationRepo _notificationRepo = NotificationRepo();
  // Singleton pattern
  static final NotificationService _notificationService =
      NotificationService._internal();
  factory NotificationService() => _notificationService;
  NotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  ///
  String deviceId = "";
  String deviceType = "";
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  ///

  /// Initialize Notification Service
  Future<void> init() async {
    await retrieveDeviceInfo();
    await requestPermission();
    await initLocalNotifications();
    await initFcmListeners();
  }

  ///
  Future<void> retrieveDeviceInfo() async {
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      deviceId = androidInfo.id; // Unique ID
      deviceType = "android";
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? ""; // Unique ID for iOS
      deviceType = "ios";
    } else {
      deviceType = "unknown";
      deviceId = "unknown"; // optional
    }
  }

  /// Request notification permissions
  Future<void> requestPermission() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    try {
      final token = await _firebaseMessaging.getToken();
      await _firebaseMessaging.subscribeToTopic("all");
      if (token != null) {
        registerToken(fcmToken: token);
      }
      print("FCM Token: $token");
    } catch (e) {
      print("FCM Token can not pulled over internet");
    }
  }

  /// Initialize local notification settings
  Future<void> initLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) {
        print("Notification Clicked!");
        print(payload.payload);
      },
    );
  }

  /// Initialize Firebase Cloud Messaging Listeners
  Future<void> initFcmListeners() async {
    // App opened from terminated state via notification
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print("App opened from terminated state");
        _handleMessage(message);
      }
    });

    // When the app is in background & user taps notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("Notification clicked while in background");
      _handleMessage(message);
    });

    // Foreground notification handler
    FirebaseMessaging.onMessage.listen((message) {
      print("Foreground Notification Received");
      showNotification(message);
    });

    // Background Handler
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  /// Show local notification
  Future<void> showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'default_channel_id',
          'General Notifications',
          channelDescription: 'This channel is used for general notifications',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
          // color: primaryColor,
          colorized: true,
        );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true, // show popup alert
      presentBadge: true, // show badge on app icon
      presentSound: true, // play sound
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      DateTime.now().millisecond,
      message.notification?.title ?? "No Title",
      message.notification?.body ?? "No Body",
      notificationDetails,
      payload: message.data.toString(),
    );
  }

  /// Handle notification click routing logic
  void _handleMessage(RemoteMessage message) {
    print("Notification Data: ${message.data}");
    print("Notification Title: ${message.notification?.title}");
    // Add navigation or your logic here
  }

  /// Background Message Handler
  @pragma('vm:entry-point')
  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print("Handling background message: ${message.messageId}");
  }

  //register token
  static registerToken({required String fcmToken}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final token = await user.getIdToken(true);

    final String url = '$baseUrl/saveFcmToken';
    try {
      final payload = jsonEncode({"token": fcmToken});
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: payload,
      );
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("successfully post the fcm token");
        print(body);
        return;
      }
      print(body);
      return;
    } catch (e) {
      print(e);
    }
  }
}
