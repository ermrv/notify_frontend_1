import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class UserFollowingsListPageController extends GetxController {
  String profileId;
  List data = [];
  bool requestProcessed = false;

  initialise() {
    getData();
  }

  getData() async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.userFollowings, {"userId":profileId}, userToken.toString());
    if (response == "error") {
      print("some error occured");
    } else {
      requestProcessed = true;
      data.addAll(response);
      update();
    }
  }

  //follow user
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

  //unfollow user
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

  TextButton getFollowButton(String userId) {
    if (PrimaryUserData.primaryUserData.followings.contains(userId)) {
      return TextButton(
          child:
              Container(alignment: Alignment.center, child: Text("Unfollow")),
          onPressed: () {
            unFollowUser(userId);
          });
    } else if (PrimaryUserData.primaryUserData.followers.contains(userId)) {
      return TextButton(
          child: Container(
              alignment: Alignment.center, child: Text("Follow Back")),
          onPressed: () {
            followUser(userId);
          });
    } else {
      return TextButton(
          child: Container(alignment: Alignment.center, child: Text("Follow")),
          onPressed: () {
            followUser(userId);
          });
    }
  }
}
