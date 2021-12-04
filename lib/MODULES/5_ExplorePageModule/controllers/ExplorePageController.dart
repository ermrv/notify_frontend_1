import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/PostGettingServices/GettingPostServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/LocalDataFiles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class ExplorePageController extends GetxController {
  double maxScrollExtent = 2.0;
  bool callScrollListener = true;
  List explorePageData = [];
  String explorePageDataFilePath;

  ScrollController scrollController;
  bool loadingMoreData = false;

  @override
  void onInit() {
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    getFileData();

    super.onInit();
  }

  ///to get the post data stored in the local storage
  getFileData() async {
    // try {
    //   explorePageData =
    //       json.decode(await File(explorePageDataFilePath).readAsString());
    //   update();
    //   getRecentPostsData();
    // } catch (e) {
    //   print(e);
    // }
    getRecentPostsData();
  }

  ///to get the latest post data
  getRecentPostsData() async {
    //if explore page data is null get all data from back end

    var response =
        await ApiServices.postWithAuth(ApiUrlsData.explorePage, {}, userToken);

    if (response != "error") {
      explorePageData = response;
      update();
      // _handleLocalFile(explorePageData);
    } else {
      print("error getting explorepage latest data");
    }
  }

  /// to get the previous post data
  getPreviousPostsData() async {
    loadingMoreData = true;
    update();
    String _lastPostId = GettingPostServices.getLastPostId(explorePageData);
    print(_lastPostId);
    var response = await ApiServices.postWithAuth(ApiUrlsData.explorePage,
        {"dataType": "previous", "postId": _lastPostId}, userToken);

    if (response != "error") {
      explorePageData.addAll(response);
      loadingMoreData = false;
      update();
      // _handleLocalFile(explorePageData);
    } else {
      loadingMoreData = false;
      update();
      print("error getting explore previous data");
    }
  }

  // ///handle the local file to store and delete the data
  // ///[data] corresponds to complete list of data
  // _handleLocalFile(List data) {
  //   print("handling explore page file");
  //   if (data.length > 10) {
  //     List _data = data.getRange(0, 10).toList();
  //     File(explorePageDataFilePath)
  //         .writeAsString(json.encode(_data), mode: FileMode.write);
  //   }
  //   //if it is less than 30, store all the data to the file
  //   else {
  //     File(explorePageDataFilePath)
  //         .writeAsString(json.encode(data), mode: FileMode.write);
  //   }
  // }

  //delete post
  //delete a post
  Future<bool> deletePost(String postId) async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.deletePost, {"postId": postId}, userToken);
    if (response == "error") {
      Get.snackbar("Some error occured", "error deleting post");
      return false;
    } else {
      int index = explorePageData.indexWhere((post) => post["_id"] == postId);
      if (index != -1) {
        explorePageData.removeAt(index);
      }
      // _handleLocalFile(explorePageData);
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
