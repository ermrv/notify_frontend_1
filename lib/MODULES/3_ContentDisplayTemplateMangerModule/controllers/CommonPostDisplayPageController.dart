import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/PostGettingServices/GettingPostServices.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CommonPostDisplayPageController extends GetxController {
  String apiUrl;
  Map<String, dynamic> apiData;

  List data;
  String title = "Posts";

  initilialise() {
    getData();
  }

  getData() async {
    var response = await ApiServices.postWithAuth(apiUrl, apiData, userToken);

    if (response != "error") {
      if (data == null) {
        data = response;
      } else {
        data.addAll(response);
      }
    }
    update();
  }

//get more post
  getMorePosts() async {
    String _lastPostId = GettingPostServices.getLastPostId(data);
    var response = await ApiServices.postWithAuth(ApiUrlsData.relatedPosts,
        {"dataType": "previous", "postId": _lastPostId}, userToken);

    if (response != "error") {
      data.addAll(response);
      update();
    } else {
      Get.snackbar("Cannot get the data", "some error occured");
    }
  }

  //delete a post
  deletePost(String postId) async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.deletePost, {"postId": postId}, userToken);
    if (response == "error") {
      Get.snackbar("Some error occured", "error deleting post");
    } else {
      int index = data.indexWhere((post) => post["_id"] == postId);
      if (index != -1) {
        data.removeAt(index);
      }
      update();
    }
  }

  @override
  void dispose() {
    data = null;
    super.dispose();
  }
}
