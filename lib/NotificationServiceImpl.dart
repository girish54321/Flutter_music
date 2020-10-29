// import 'package:firebase_messaging/firebase_messaging.dart';

// class NotificationServiceImpl {
// // make it singleton pls
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//   // static final NotificationServiceImpl _singleton =
//   //     NotificationServiceImpl._internal();

//   static Future<dynamic> myBackgroundMessageHandler(
//       Map<String, dynamic> message) {
//     print("triggerd");

//     if (message.containsKey('data')) {
//       // Handle data message
//       final dynamic data = message['data'];
//     }

//     if (message.containsKey('notification')) {
//       // Handle notification message
//       final dynamic notification = message['notification'];
//     }

//     return null;
//     // Or do other work.
//   }

//   bool _initialized = false;
//   String _fcmToken;

//   Future<void> init() async {
//     if (!_initialized) {
//       // For iOS request permission first.
//       _firebaseMessaging.requestNotificationPermissions();

//       // _firebaseMessaging.configure();

//       _firebaseMessaging.configure(
//         onMessage: (Map<String, dynamic> message) async {
//           print("onMessage: $message");
//         },
//         onBackgroundMessage: myBackgroundMessageHandler,
//         onLaunch: (Map<String, dynamic> message) async {
//           print("onLaunch: $message");
//         },
//         onResume: (Map<String, dynamic> message) async {
//           print("onResume: $message");
//         },
//       );

//       _fcmToken = await _firebaseMessaging.getToken();
//       print("Token : " + _fcmToken);

//       _initialized = true;
//     }
//   }

//   Future<String> getToken() async {
//     if (!_initialized) {
//       await init();
//     }
//     return _fcmToken;
//   }
// }
