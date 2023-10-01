import 'package:avrod/main.dart';
import 'package:avrod/screens/text_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
// create an instance of Firebase Messagin
  final _firebaseMessaging = FirebaseMessaging.instance;

// function to initilaze notification
  Future<void> initNotifications() async {
// request permission from user
    await _firebaseMessaging.requestPermission();

    final token = await _firebaseMessaging.getToken();

    print(token);
  }

// function to handle received messages

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState
        ?.pushNamed(TextScreen.routName, arguments: message);
  }

// function to initilaze foreground and background settings

Future initPushNotification()async{
FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
 

 FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

}

  Future<void> firebaseMessagingSettings() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }
}
