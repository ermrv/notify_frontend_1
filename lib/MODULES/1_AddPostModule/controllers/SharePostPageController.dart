import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/14_MainNavigationModule/views/MainNavigation.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SharePostPageController extends GetxController {
  String postId;
  String sharedDescription;
  String location;
  bool isUploading = false;

  TextEditingController textEditingController;

  initialise() {
    textEditingController = TextEditingController();
  }

  uploadPost() async {
    isUploading = true;
    update();
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.sharePost,
        {
          "sharedDescription": textEditingController.text,
          "postId": postId,
          "postLocation": "location"
        },
        userToken);

    if (response != "error") {
      isUploading = false;
      textEditingController.dispose();

      Get.back();
    } else {
      isUploading = false;

      update();
    }
  }
}
