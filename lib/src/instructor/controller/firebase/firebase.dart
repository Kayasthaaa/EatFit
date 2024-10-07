// // ignore_for_file: unused_local_variable

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'dart:io';

// class FCMService {
//   static final FCMService _instance = FCMService._internal();
//   factory FCMService() => _instance;
//   FCMService._internal();

//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   bool _isInitialized = false;

//   Future<void> initialize() async {
//     if (_isInitialized) return;

//     await Firebase.initializeApp();

//     if (Platform.isIOS) {
//       await _requestIOSPermission();
//     }

//     FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//     // Set up token refresh listener
//     _firebaseMessaging.onTokenRefresh.listen(_onTokenRefresh);

//     _isInitialized = true;
//   }

//   Future<void> _requestIOSPermission() async {
//     NotificationSettings settings = await _firebaseMessaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//   }

//   Future<String?> getFCMToken() async {
//     if (!_isInitialized) {
//       await initialize();
//     }

//     try {
//       String? token = await _firebaseMessaging.getToken();
//       return token;
//     } catch (e) {
//       return null;
//     }
//   }

//   Future<void> _onTokenRefresh(String token) async {
//     // Here you can send the new token to your server
//   }

//   Future<void> subscribeToTopic(String topic) async {
//     await _firebaseMessaging.subscribeToTopic(topic);
//   }

//   Future<void> unsubscribeFromTopic(String topic) async {
//     await _firebaseMessaging.unsubscribeFromTopic(topic);
//   }

//   void _handleForegroundMessage(RemoteMessage message) {
//     // Handle the message as needed
//   }

//   void _handleBackgroundMessage(RemoteMessage message) {
//     // Handle the message as needed
//   }
// }

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   // Handle the background message
// }
