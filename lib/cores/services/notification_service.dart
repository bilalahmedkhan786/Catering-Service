import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FCMService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void initializeFCM(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        // Handle foreground messages
        _showNotification(message.notification!);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle when the app is opened from a notification
      _handleMessage(message, context);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // Handle background messages
    print("Handling a background message: ${message.messageId}");
  }

  void _showNotification(RemoteNotification notification) {
    // Implement a method to show notifications
    // Use the flutter_local_notifications package for local notifications
  }

  void _handleMessage(RemoteMessage message, BuildContext context) {
    // Handle navigation or actions based on notification data
  }
}
