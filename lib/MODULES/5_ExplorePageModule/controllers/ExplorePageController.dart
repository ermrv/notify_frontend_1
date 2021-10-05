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

  ScrollController scrollController;

  @override
  void onInit() {
     scrollController = ScrollController();
    scrollController.addListener(scrollListener);
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

    getRecentPostsData();
  }

  ///to get the latest post data
  getRecentPostsData() async {
    //if newsfeed data is null get all data from back end

    var response = await ApiServices.postWithAuth(
        "http://139.59.8.116:3000/api/explore", {}, userToken);

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

  //delete post
  //delete a post
  deletePost(String postId) async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.deletePost, {"postId": postId}, userToken);
    if (response == "error") {
      Get.snackbar("Some error occured", "error deleting post");
    } else {
      int index = explorePageData.indexWhere((post) => post["_id"] == postId);
      if (index != -1) {
        explorePageData.removeAt(index);
      }
      _handleLocalFile(explorePageData);
      update();
    }
  }

   ///listen to the scroll of the newfeed in order to load more data
  ///calls [getPreviousPostsData] when scroll is attend to a limit
  scrollListener() {
    if (scrollController.position.maxScrollExtent ==
        scrollController.position.pixels) {
      String lastPostId = explorePageData.last["_id"];
      getPreviousPostsData(lastPostId);
    }
  }

 
}
