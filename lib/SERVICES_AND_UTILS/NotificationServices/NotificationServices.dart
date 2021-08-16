import 'dart:io';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/AddPostPageScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

abstract class NotificationServices {
  static Future initialise() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    //if platform is ios ask for permission
    if (Platform.isIOS) {
      FirebaseMessaging.instance.requestPermission();
    }

    if (Platform.isIOS || Platform.isAndroid) {
      AndroidNotificationChannel channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        'This channel is used for important notifications.', // description
        importance: Importance.high,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    ///handling foreground message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                'high_importance_channel', // id
                'High Importance Notifications', // title
                'This channel is used for important notifications.', // description
                importance: Importance.high,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(message.data);
      var notificationData = message.data;
      String view = notificationData["view"].toString();
      if (view != null) {
        switch (view) {
          case "createPost":
            print("addpostpage");
            Get.to(() => AddPostPageScreen());

            break;
          default:
        }
      }
    });
  }
}
