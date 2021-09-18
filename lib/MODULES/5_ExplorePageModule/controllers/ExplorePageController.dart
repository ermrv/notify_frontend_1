import 'dart:convert';
import 'dart:io';

import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/LocalDataFiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class ExplorePageController extends GetxController {
  double maxScrollExtent = 2.0;
  bool callScrollListener = true;
  List explorePageData = [];
  String explorePageDataFilePath;

  @override
  void onInit() {
    explorePageDataFilePath = LocalDataFiles.explorePageDataFilePath;
    getFileData();

    super.onInit();
  }

  ///to get the post data stored in the local storage
  getFileData() async {
    try {
      explorePageData =
          json.decode(await File(explorePageDataFilePath).readAsString());
      update();
      getRecentPostsData();
    } catch (e) {
      print(e);
      getRecentPostsData();
    }
  }

  ///to get the latest post data
  getRecentPostsData() async {
    //if newsfeed data is null get all data from back end

    var response = await ApiServices.postWithAuth(
        ApiUrlsData.explorePage, {"dataType": "latest"}, userToken);

    if (response != "error") {
      List _temp = response;
      _temp.addAll(explorePageData);
      explorePageData.clear();
      explorePageData.addAll(_temp);
      update();
      _handleLocalFile(explorePageData);
    } else {
      print("error getting explorepage latest data");
    }
  }

  /// to get the previous post data
  getPreviousPostsData(String lastPostId) async {
    var response;
    if (lastPostId == "null") {
      response = await ApiServices.postWithAuth(
          ApiUrlsData.explorePage, {"dataType": "previous"}, userToken);
    } else {
      response = await ApiServices.postWithAuth(ApiUrlsData.explorePage,
          {"dataType": "previous", "postId": lastPostId}, userToken);
    }

    if (response != "error") {
      explorePageData.addAll(response);
      update();
      _handleLocalFile(explorePageData);
    } else {
      print("error getting explore previous data");
    }
  }

  ///handle the local file to store and delete the data
  ///[data] corresponds to complete list of data
  _handleLocalFile(List data) {
    File(explorePageDataFilePath)
        .writeAsString(json.encode(data), mode: FileMode.write);
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
