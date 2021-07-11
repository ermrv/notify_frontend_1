import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class NewsFeedPageController extends GetxController {
  double maxScrollExtent = 2.0;
  bool callScrollListener = true;
  List data = [];
  List userStatusData = [];

  @override
  void onInit() {
    getUserStatusData();
    getData();
    super.onInit();
  }

  getData() async {
    var response =
        await ApiServices.postWithAuth(ApiUrlsData.newsFeedUrl, {}, userToken);
    //store the previous data
    List _previousData = data;

    //make the data list null
    data = [];
    //add the recent data in the data list

    data.addAll(response);

    //now add the previous data to the list
    data.addAll(_previousData);

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
