// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// import 'core/constants/constants.dart';
//
//
//   Future<void> sendAndRetrieveMessage(
//       {required String title, required String body}) async {
//     await FirebaseMessaging.instance.requestPermission(
//       sound: true,
//       badge: true,
//       alert: true,
//       provisional: false,
//     );
//
//     await http.post(
//       Uri.parse('https://fcm.googleapis.com/fcm/send'),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization': 'key=$serverToken',
//       },
//       body: jsonEncode(
//         <String, dynamic>{
//           'notification': <String, dynamic>{
//             'body': body.toString(),
//             'title': title.toString()
//           },
//           'priority': 'high',
//           'data': <String, dynamic>{
//             'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//             'status': 'done'
//           },
//           // 'to': await firebaseMessaging.getToken(),
//           'to': '/topics/ChatAppTopic',
//         },
//       ),
//     );
//   }
//
