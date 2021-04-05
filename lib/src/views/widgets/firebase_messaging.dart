////import 'package:flutter/material.dart';
////import 'package:firebase_messaging/firebase_messaging.dart';
////import 'package:heed/src/models/firebase_messaging_model/message_model.dart';
////import 'package:flutter_local_notifications/flutter_local_notifications.dart';
////
//
//class MessagingHandler extends StatefulWidget {
//  @override
//  _MessagingHandlerState createState() => _MessagingHandlerState();
//}
//
//class _MessagingHandlerState extends State<MessagingHandler> {
//
//  final FirebaseMessaging _messaging = FirebaseMessaging();
//  final List<FireBaseMessage> messages = [];
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//
//
//
//    _messaging.getToken().then((token){
//      print(token);
//    });
//
//
//    _messaging.configure(
//      onMessage: (Map<String , dynamic> message) async {
//        showNotification(message);
//        print(message);
//      },
//      onLaunch: (Map<String , dynamic> message) async {
//        showNotification(message);
//      },
//      onResume: (Map<String , dynamic> message) async {
//        showNotification(message);
//      },
//    );
//    _messaging.requestNotificationPermissions(
//      const IosNotificationSettings(sound: true,badge: true,alert: true)
//    );
//  }
//
//
//
//  void showNotification(Map<String , dynamic> payload) {
//    final notification = payload["data"];
//    final action = notification["action"];
//    final message = notification["message"];
//
//
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//
//
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Test Messaging"),
//      ),
//      body: Container(),
//    );
//
//
//  }
//
//
//
//
//
//}
