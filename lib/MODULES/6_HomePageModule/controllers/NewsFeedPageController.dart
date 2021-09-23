import 'dart:convert';
import 'dart:io';

import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/LocalDataFiles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/services.dart' as flutterServices;

class NewsFeedPageController extends GetxController {
  double maxScrollExtent = 2.0;
  bool callScrollListener = true;
  List newsFeedData;
  List userStatusData = [];
  String newsFeedDataFilePath;

  ScrollController scrollController;

  @override
  void onInit() {
    newsFeedDataFilePath = LocalDataFiles.newsFeedPostsDataFilePath;
    getFileData();
    getUserStatusData();
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    super.onInit();
  }

  ///to get the post data stored in the local storage
  getFileData() async {
    try {
      newsFeedData =
          json.decode(await File(newsFeedDataFilePath).readAsString());
      print(newsFeedData.length);
      update();
    } catch (e) {
      print(e);
    }

    getRecentPostsData();
  }

  ///to get the latest post data
  getRecentPostsData() async {
    var response;
    //if newsfeed data is null get all data from back end
    if (newsFeedData == null) {
      response = await ApiServices.postWithAuth(
          ApiUrlsData.newsFeedUrl, {"dataType": "latest"}, userToken);
    }
    //if list is empty get all data from backend
    else if (newsFeedData.length == 0) {
      response = await ApiServices.postWithAuth(
          ApiUrlsData.newsFeedUrl, {"dataType": "latest"}, userToken);
    }
    //if newsfeed data is available, get only those data that is  recent
    else if (newsFeedData.length >= 1) {
      String latestPostId = newsFeedData[0]["_id"];
      print(latestPostId);
      response = await ApiServices.postWithAuth(ApiUrlsData.newsFeedUrl,
          {"dataType": "latest", "postId": latestPostId}, userToken);
    }

    if (response != "error") {
      if (newsFeedData == null) {
        newsFeedData = response;
        update();
        _handleLocalFile(newsFeedData);
      } else {
        List _temp = response;
        _temp.addAll(newsFeedData);
        newsFeedData.clear();
        newsFeedData.addAll(_temp);
        update();
        _handleLocalFile(newsFeedData);
      }
    } else {
      print("error getting newsfeed latest data");
    }
  }

  /// to get the previous post data
  getPreviousPostsData(String lastPostId) async {
    var response;
    if (lastPostId == "null") {
      response = await ApiServices.postWithAuth(
          ApiUrlsData.newsFeedUrl, {"dataType": "previous"}, userToken);
    } else {
      response = await ApiServices.postWithAuth(ApiUrlsData.newsFeedUrl,
          {"dataType": "previous", "postId": lastPostId}, userToken);
    }

    if (response != "error") {
      if (newsFeedData == null) {
        newsFeedData = response;
        update();
        _handleLocalFile(newsFeedData);
      } else {
        newsFeedData.addAll(response);
        update();
        _handleLocalFile(newsFeedData);
      }
    } else {
      print("error getting newsfeed previous data");
    }
  }

  ///handle the local file to store and delete the data
  ///[data] corresponds to complete list of data
  _handleLocalFile(List data) {
    //if data length is greater than 30, store the first 30 in the file
    if (data.length > 30) {
      List _data = data.getRange(0, 30).toList();
      File(newsFeedDataFilePath)
          .writeAsString(json.encode(_data), mode: FileMode.write);
    }
    //if it is less than 30, store all the data to the file
    else {
      File(newsFeedDataFilePath)
          .writeAsString(json.encode(data), mode: FileMode.write);
    }
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

  ///listen to the scroll of the newfeed in order to load more data
  ///calls [getPreviousPostsData] when scroll is attend to a limit
  scrollListener() {
    if (scrollController.position.maxScrollExtent ==
        scrollController.position.pixels) {
      String lastPostId = newsFeedData.last["_id"];
      getPreviousPostsData(lastPostId);
    }
  }
}
