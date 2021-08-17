import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class ExplorePageController extends GetxController
    with SingleGetTickerProviderMixin {
  double maxScrollExtent = 2.0;
  bool callScrollListener = true;
  List data = [];

  @override
  void onInit() {
    getData();

    super.onInit();
  }

  getData() async {
    var response =
        await ApiServices.postWithAuth(ApiUrlsData.explorePage, {}, userToken);

    data.addAll(response["boxes"]);
    update();
  }

  scrollListenerToGetData(ScrollNotification notification) {
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

  // ///function to collapse and build the appbar during scroll
  // appBarHeightHandler(ScrollNotification notification) {
  //   if (notification.metrics.axis == Axis.vertical) {
  //     //collapse if scroll extent is  more than 50 pxls and build if less than 50
  //     if (notification.metrics.pixels >= 50.0) {
  //       animationController.forward();
  //     } else if (notification.metrics.pixels < 50.0) {
  //       animationController.reverse();
  //     }
  //   }
  // }
}
