import 'dart:convert';

import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/LocalDataFiles.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' as flutterServices;

class NewsFeedPageController extends GetxController {
  double maxScrollExtent = 2.0;
  bool callScrollListener = true;
  List newsFeedData;
  List userStatusData = [];

  @override
  void onInit() {
    getUserStatusData();
    getData();
    super.onInit();
  }

  getData() async {
    var data = await LocalDataFiles.newsFeedPostsDataFile.readAsString();
    print(data);
    update();
    var response =
        await ApiServices.postWithAuth(ApiUrlsData.newsFeedUrl, {}, userToken);
    // //store the previous data
    // List _previousData = data;

    // //make the data list null
    // data = [];
    // //add the recent data in the data list

    newsFeedData = response;
    await LocalDataFiles.newsFeedPostsDataFile.writeAsString(jsonEncode(response));
    // //now add the previous data to the list
    // data.addAll(_previousData);
    update();
  }

  ///getting user status data
  getUserStatusData() async {
    var response =
        await ApiServices.postWithAuth(ApiUrlsData.getStatus, {}, userToken);
    if (response == "error") {
      print("error");
    } else {
      userStatusData.addAll(response);
      update();
    }
  }

  scrollListener(ScrollNotification notification) {
    if (notification.metrics.axisDirection == AxisDirection.down) {
      double _maxScrollExtent = notification.metrics.maxScrollExtent;
      if (notification.metrics.pixels.floor() >=
              (notification.metrics.maxScrollExtent * 0.9).floor() &&
          callScrollListener) {
        print("bottom");

        maxScrollExtent = _maxScrollExtent;
        callScrollListener = false;
        update();
      } else if (notification.metrics.pixels.floor() >=
              maxScrollExtent.floor() &&
          !callScrollListener) {
        callScrollListener = true;
        update();
      }
    }
  }
}
