import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// WARNING: currently not checking if FCMToken updates (it is only set once during signup)
// See here for code on how to listen for updates: https://firebase.google.com/docs/cloud-messaging/flutter/get-started

class NotificationRepository {
  final FirebaseMessaging _firebaseMessaging;

  NotificationRepository(this._firebaseMessaging);

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
  }

  Future<String?> getNotificationToken() async {
    await initNotifications();
    return _firebaseMessaging.getToken();
  }
}

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository(FirebaseMessaging.instance);
});
