import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationManager {
  PushNotificationManager._();

  factory PushNotificationManager() => _instance;

  static final PushNotificationManager _instance = PushNotificationManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure();

      String token = await _firebaseMessaging.getToken();

      _initialized = true;
    }
  }
}
