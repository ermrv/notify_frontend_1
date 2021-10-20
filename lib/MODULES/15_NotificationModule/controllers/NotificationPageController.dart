import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/NotificationServices/NotificationServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPageController extends GetxController {
  List notificationsData;
  @override
  void onInit() {
    getData();

    super.onInit();
  }

  getData() async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.allNotifications, {}, userToken);
    if (response == "error") {
      Get.snackbar("Cannot get notifications", "some error occured");
    } else {
      notificationsData = response;
      update();
    }
  }
}
