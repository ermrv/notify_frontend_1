import 'package:MediaPlus/MODULES/7_UserAuthModule/views/UserAuthScreen.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/AppThemeModule/controllers/ThemeController.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/BackgroundTaskManager/BackgroundTaskManager.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/NotificationServices/NotificationServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'package:double_back_to_close/double_back_to_close.dart';


//handling the background notification
Future<void> _backgroundNotificationHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

//handling background tasks
void callBackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    print("background task");
    print(task);
    BackgroundTaskManager.backgroundTaskManager(task, inputData);
    return Future.value(true);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Workmanager().initialize(callBackDispatcher);
  FirebaseMessaging.onBackgroundMessage(_backgroundNotificationHandler);

  await GetStorage.init();
  await NotificationServices.initialise();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeController.getTheme("dark"),
        home: DoubleBack(
          message: "Press back again to exit",
          
          child: UserAuthScreen()));
  }
}
