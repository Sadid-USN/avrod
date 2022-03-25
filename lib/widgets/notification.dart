import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_flutternotification');

    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(
      int id, String title, String body, int time) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(Duration(seconds: time)),
        const NotificationDetails(
          android: AndroidNotificationDetails('channel id', 'channel name',
              channelDescription: 'Main channel notifications',
              sound: RawResourceAndroidNotificationSound('notification_sound'),
              playSound: true,
              importance: Importance.max,
              priority: Priority.max,
              icon: '@drawable/ic_flutternotification'),
          iOS: IOSNotificationDetails(
            sound: 'notification_sound',
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  Future<void> dailyAtNotification(
      int id, String title, String body, int time) async {
    //   var time = const Time(19, 25, 0);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.local(1).add(const Duration(days: 1)),
        const NotificationDetails(
          android: AndroidNotificationDetails('channel id', 'channel name',
              channelDescription: 'Main channel notifications',
              sound: RawResourceAndroidNotificationSound('notification_sound'),
              playSound: true,
              importance: Importance.max,
              priority: Priority.max,
              icon: '@drawable/ic_flutternotification'),
          iOS: IOSNotificationDetails(
            sound: 'notification_sound',
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);

    // Future<void> cancelAllNotifications() async {
    //   await flutterLocalNotificationsPlugin.cancelAll();
    // }
  }
}

class ListNotiece {
  List<String>? title;
  List<String>? notiece;

  ListNotiece({
    this.title,
    this.notiece,
  });
}

final listnotiece = ListNotiece(
  title: [
    "Дуо сипари мусалмон аст",
    "Паёмбар (ﷺ) гуфтааст:",
    "Дуои Закариё (ﷺ)",
    "Аллоҳ таъоло мефармояд:",
    "Аз дуоҳои паёмбар (ﷺ)",
  ].toList(),
  notiece: [
    "Парвардигоратон фармуд: «Маро бихонед, то [дуои] шуморо иҷобат кунам» (Ғофир 60)",
    "«Ҳарки аз Аллоҳ пурсишу дархост намекунад, бар ӯ ғазаб хоҳад кард. (Тирмизӣ 3373)",
    "«Эй Парвардигорам, [ҳаргиз] дар дуои ту [аз иҷобат] бебаҳра набудаам». (Марям 4)",
    "«Ман наздикам ва дуои дуокунандаро – чун маро бихонад – иҷобат мекунам».(Бақара 186)",
    "Илоҳо, аз ту дархост мекунам, ки диламро сиҳату солим гардони",
    "",
  ].toList(),
);
