import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/PostGettingServices/GettingPostServices.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class OtherUserProfilePageController extends GetxController {
  String thisUserId;
  String profileOwnerId;

  List postData;
  var profileData;
  bool loadingMoreData = false;

  ScrollController scrollController;

  initialise() {
    getData();
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
  }

  getData() async {
    await getBasicProfileData();

    var response = await ApiServices.postWithAuth(
        ApiUrlsData.otherUserPosts, {"userId": profileOwnerId}, userToken);
    if (response != "error") {
      postData = response;
      update();
    }
  }

  /// to get the previous post data
  getPreviousPostsData() async {
    print("getting previous data");
    loadingMoreData = true;
    update();
    String _lastPostId = GettingPostServices.getLastPostId(postData);
    print(_lastPostId);

    var response = await ApiServices.postWithAuth(ApiUrlsData.newsFeedUrl,
        {"dataType": "previous", "postId": _lastPostId}, userToken);

    if (response != "error") {
      if (postData == null) {
        postData = response;
        loadingMoreData = false;
        update();
      } else {
        loadingMoreData = false;
        postData.addAll(response);
        update();
      }
    } else {
      loadingMoreData = false;
      update();
      Get.snackbar("Cannot get the data", "some error occured");
    }
  }

  ///getting basic user data
  getBasicProfileData() async {
    print(profileOwnerId);
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.otherUserProfileBasicData,
        {"userId": profileOwnerId},
        userToken);
    if (response != "error") {
      profileData = response;
      update();
    }
  }

  //delete a post
  deletePost(String postId) async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.deletePost, {"postId": postId}, userToken);
    if (response == "error") {
      Get.snackbar("Some error occured", "error deleting post");
    } else {
      int index = postData.indexWhere((post) => post["_id"] == postId);
      if (index != -1) {
        postData.removeAt(index);
      }
      update();
    }
  }

  scrollListener() {
    if (scrollController.position.maxScrollExtent ==
        scrollController.position.pixels) {
      getPreviousPostsData();
    }
  }

  @override
  void dispose() {
    postData = null;
    profileData = null;
    profileOwnerId = null;
    super.dispose();
  }
}
