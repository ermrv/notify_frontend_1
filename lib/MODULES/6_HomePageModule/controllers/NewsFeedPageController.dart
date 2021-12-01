import 'dart:convert';
import 'dart:io';

import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/PostGettingServices/GettingPostServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/LocalDataFiles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/services.dart' as flutterServices;

class NewsFeedPageController extends GetxController {
  double maxScrollExtent = 2.0;
  bool callScrollListener = true;
  List newsFeedData;
  List trendingPostData = [];
  String newsFeedDataFilePath;

  ScrollController scrollController;

  @override
  void onInit() {
    newsFeedDataFilePath = LocalDataFiles.newsFeedPostsDataFilePath;
    getFileData();
    gettrendingPostData();
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
    if (newsFeedData == null || LocalDataFiles.refreshNewsFeedFile) {
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
      String _firstPostId = GettingPostServices.getFirstPostId(newsFeedData);
      response = await ApiServices.postWithAuth(ApiUrlsData.newsFeedUrl,
          {"dataType": "latest", "postId": _firstPostId}, userToken);
    }

    if (response != "error") {
      if (newsFeedData == null || LocalDataFiles.refreshNewsFeedFile) {
        newsFeedData = response;
        update();
        _handleLocalFile(newsFeedData);
        LocalDataFiles.setRefreshNewsFeedFile(false);
      } else {
        List _temp = response;
        _temp.addAll(newsFeedData);
        newsFeedData.clear();
        newsFeedData.addAll(_temp);
        update();
        _handleLocalFile(newsFeedData);
      }
    } else {
      Get.snackbar("Cannot get the data", "some error occured");
    }
  }

  /// to get the previous post data
  getPreviousPostsData() async {
    String _lastPostId = GettingPostServices.getLastPostId(newsFeedData);
    print(_lastPostId);

    var response = await ApiServices.postWithAuth(ApiUrlsData.newsFeedUrl,
        {"dataType": "previous", "postId": _lastPostId}, userToken);

    if (response != "error") {
      if (newsFeedData == null) {
        newsFeedData = response;
        update();
      } else {
        newsFeedData.addAll(response);
        update();
      }
    } else {
      Get.snackbar("Cannot get the data", "some error occured");
    }
  }

  ///handle the local file to store and delete the data
  ///[data] corresponds to complete list of data
  _handleLocalFile(List data) {
    print(newsFeedData.length);
    //if data length is greater than 30, store the first 30 in the file
    if (data.length > 10) {
      List _data = data.getRange(0, 10).toList();
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
  gettrendingPostData() async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.treindingPostData, {}, userToken);
    if (response == "error") {
      print("error");
    } else {
      trendingPostData.addAll(response);
      update();
    }
  }

  ///delete post
  //delete a post
  deletePost(String postId) async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.deletePost, {"postId": postId}, userToken);
    if (response == "error") {
      Get.snackbar("Some error occured", "error deleting post");
    } else {
      int index = newsFeedData.indexWhere((post) => post["_id"] == postId);
      if (index != -1) {
        newsFeedData.removeAt(index);
      }
      _handleLocalFile(newsFeedData);
      update();
    }
  }

  ///listen to the scroll of the newfeed in order to load more data
  ///calls [getPreviousPostsData] when scroll is attend to a limit
  scrollListener() {
    if (scrollController.position.maxScrollExtent ==
        scrollController.position.pixels) {
      getPreviousPostsData();
    }
  }
}
