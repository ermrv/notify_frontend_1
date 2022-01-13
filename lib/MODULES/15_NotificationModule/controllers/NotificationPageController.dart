import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/NotificationServices/NotificationServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/PostGettingServices/GettingPostServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPageController extends GetxController {
  List notificationsData;
  bool loadingMoreData = false;
  ScrollController scrollController;

  @override
  void onInit() {
    getData();
scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    super.onInit();
  }

  getData() async {
    String gtoken = await NotificationServices.getFcmToken();
    print("fcm token" + gtoken);
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.allNotifications, {"dataType": "latest"}, userToken);
    if (response == "error") {
      Get.snackbar("Cannot get notifications", "some error occured");
    } else {
      notificationsData = response;
      update();
    }
  }

  ///getting previous notifications
  getPreviousData() async {
    loadingMoreData = true;
    update();
    String _lastPostId = GettingPostServices.getLastPostId(notificationsData);
    var response = await ApiServices.postWithAuth(ApiUrlsData.allNotifications,
        {"dataType": "previous", "notificationId": _lastPostId}, userToken);
    if (response == "error") {
      Get.snackbar("Cannot get notifications", "some error occured");
      loadingMoreData = false;
      update();
    } else {
      notificationsData.addAll(response);
      loadingMoreData = false;
      update();
    }
  }

  followUser(String userId) async {
    PrimaryUserData.primaryUserData.followings.add(userId);
    update();
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.followUser, {"userId": userId}, userToken);
    if (response != "error") {
      try {
        PrimaryUserData.primaryUserData.deleteLocalUserBasicDataFile();
      } catch (e) {
        print(e);
      }
    }
  }

  unFollowUser(String userId) async {
    PrimaryUserData.primaryUserData.followings.remove(userId);
    update();
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.unfollowUser, {"userId": userId}, userToken);
    if (response != "error") {
      try {
        PrimaryUserData.primaryUserData.deleteLocalUserBasicDataFile();
      } catch (e) {
        print(e);
      }
    }
  }

  TextButton getFollowButton(String userId, bool isCenterAligned) {
    if (PrimaryUserData.primaryUserData.followings.contains(userId)) {
      return TextButton(
          child: isCenterAligned
              ? Container(alignment: Alignment.center, child: Text("Unfollow"))
              : Container(child: Text("Unfollow")),
          onPressed: () {
            unFollowUser(userId);
          });
    } else if (PrimaryUserData.primaryUserData.followers.contains(userId)) {
      return TextButton(
          child: isCenterAligned
              ? Container(
                  alignment: Alignment.center, child: Text("Follow Back"))
              : Container(child: Text("Follow Back")),
          onPressed: () {
            followUser(userId);
          });
    } else {
      return TextButton(
          child: isCenterAligned
              ? Container(alignment: Alignment.center, child: Text("Follow"))
              : Container(child: Text("Follow")),
          onPressed: () {
            followUser(userId);
          });
    }
  }

  ///listen to the scroll of the newfeed in order to load more data
  ///calls [getPreviousPostsData] when scroll is attend to a limit
  scrollListener() {
    if (scrollController.position.maxScrollExtent ==
        scrollController.position.pixels) {
      getPreviousData();
    }
  }
}
