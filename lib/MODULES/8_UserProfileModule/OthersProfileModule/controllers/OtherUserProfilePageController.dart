import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class OtherUserProfilePageController extends GetxController {
  String thisUserId;
  String profileOwnerId;

  List postData;
  var profileData;

  initialise() {
    getData();
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
}
