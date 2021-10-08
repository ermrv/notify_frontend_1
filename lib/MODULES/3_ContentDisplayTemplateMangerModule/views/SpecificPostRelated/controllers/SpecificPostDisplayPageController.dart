import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:get/get.dart';

class SpecificPostDisplayPageController extends GetxController {
  String specificPostId;
  var specificPostData;
  List recommendedPostData;

  getSpecificPostData() async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.specificPostDetail, {"postId": specificPostId}, userToken);
    if (response != "error") {
      specificPostData = response;
      update();
      getRecommendedPostData();
    } else {
      Get.snackbar("error getting specific post data", "/post/detail");
    }
  }

  getRecommendedPostData() async {}
}
