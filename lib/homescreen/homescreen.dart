import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pushnotification/homescreen/demo_screen.dart';
import 'package:pushnotification/homescreen/testScreen.dart';

import '../notificaton_service/local_notification_service.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    super.initState();
    FCMToken();

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification, even if the  app is in terminated state , the app will open when u click the notification and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          print('should navigate without id');
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DemoScreen(
                id: message.data['_id'],
              ),
            ),
          );
          // }
        }
      },
    );
    // 2. This method only call when App in running: it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TestScreen(),
            ),
          );
        }
      },
    );
    // 3. This method only call when App is in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DemoScreen(
                id: message.data['_id'],
              ),
            ),
          );
        }
      },
    );
  }

  void FCMToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print('fcmToken  -----------> $fcmToken');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Push Notification App'),
      ),
      body: Center(child: Text('Notification')),
    );
  }
}
