import 'dart:convert';
import 'dart:io';

import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/NotificationServices/NotificationServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/PostGettingServices/GettingPostServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/LocalDataFiles.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class OwnProfilePageScreenController extends GetxController {
  List profilePostData;

  String userProfileDataFilePath;

  ScrollController scrollController;
  bool loadingMoreData = false;

  var userProfileData;

  @override
  void onInit() {
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    userProfileDataFilePath = LocalDataFiles.profilePostsDataFilePath;
    getFileData();
    getUserBasicData();
    super.onInit();
  }

  ///to get the user basic data and refresh the saved data
  getUserBasicData() async {
    String fcmToken = await NotificationServices.getFcmToken();
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.appStart, {"fcmToken": fcmToken}, userToken.toString());
    if (response == "error") {
      Get.snackbar("Error", "Cannot get the data");
    } else {
      userProfileData = response;
      print(userProfileData);
      PrimaryUserData.primaryUserData.jsonToModel(response);
      update();

      //write the data to local file
      await File(LocalDataFiles.userBasicDataFilePath)
          .writeAsString(json.encode(response), mode: FileMode.write);
    }
  }

  ///to get the post data stored in the local storage
  getFileData() async {
    getRecentPostsData();
  }

  ///to get the latest post data
  getRecentPostsData() async {
    var response;
    //if  data is null get all data from back end
    if (profilePostData == null || LocalDataFiles.refreshProfilePostsFile) {
      response = await ApiServices.postWithAuth(
          ApiUrlsData.userPosts, {"dataType": "latest"}, userToken);
    }
    //if list is empty get all data from backend
    else if (profilePostData.length == 0) {
      response = await ApiServices.postWithAuth(
          ApiUrlsData.userPosts, {"dataType": "latest"}, userToken);
    }
    //if  data is available, get only those data that is  recent
    else if (profilePostData.length >= 1) {
      String _latestPostId =
          GettingPostServices.getFirstPostId(profilePostData);

      response = await ApiServices.postWithAuth(ApiUrlsData.userPosts,
          {"dataType": "latest", "postId": _latestPostId}, userToken);
    }

    if (response != "error") {
      if (profilePostData == null || LocalDataFiles.refreshProfilePostsFile) {
        profilePostData = response;
        update();
        // _handleLocalFile(profilePostData);
      } else {
        List _temp = response;
        _temp.addAll(profilePostData);
        profilePostData.clear();
        profilePostData.addAll(_temp);
        update();
        // _handleLocalFile(profilePostData);
      }
    } else {
      print("error getting profile  latest data");
    }
  }

  // to get the previous post data
  getPreviousPostsData() async {
    print("getting previous data");
    loadingMoreData = true;
    update();
    String _lastPostId = GettingPostServices.getLastPostId(profilePostData);
    print(_lastPostId);

    var response = await ApiServices.postWithAuth(ApiUrlsData.newsFeedUrl,
        {"dataType": "previous", "postId": _lastPostId}, userToken);

    if (response != "error") {
      if (profilePostData == null) {
        profilePostData = response;
        loadingMoreData = false;
        update();
      } else {
        loadingMoreData = false;
        profilePostData.addAll(response);
        update();
      }
    } else {
      loadingMoreData = false;
      update();
      Get.snackbar("Cannot get the data", "some error occured");
    }
  }

  // ///handle the local file to store and delete the data
  // ///[data] corresponds to complete list of data
  // _handleLocalFile(List data) {
  //   //if data length is greater than 30, store the first 30 in the file
  //   if (data.length > 10) {
  //     List _data = data.getRange(0, 10).toList();
  //     File(userProfileDataFilePath)
  //         .writeAsString(json.encode(_data), mode: FileMode.write);
  //   }
  //   //if it is less than 30, store all the data to the file
  //   else {
  //     File(userProfileDataFilePath)
  //         .writeAsString(json.encode(data), mode: FileMode.write);
  //   }
  // }

  //delete a post
  Future<bool> deletePost(String postId) async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.deletePost, {"postId": postId}, userToken);
    if (response == "error") {
      Get.snackbar("Some error occured", "error deleting post");
      return false;
    } else {
      int index = profilePostData.indexWhere((post) => post["_id"] == postId);
      if (index != -1) {
        profilePostData.removeAt(index);
      }
      // _handleLocalFile(profilePostData);
      update();
      return true;
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
