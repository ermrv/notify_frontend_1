import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/10_PostPromotionModule/views/PaymentProcessPageScreen.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PromotedPostActionSelectorController extends GetxController {
  String postId;
  int totalAudience;
  int duration;
  int budget;

  bool isProcessing = false;

  String redirectionType = "profile";
  String redirectionUrl = PrimaryUserData.primaryUserData.userId;

  TextEditingController textEditingController;

  setRedirectionType(String type) {
    redirectionType = type;
    update();
  }

  sendData() async {
    isProcessing = true;
    update();
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.addPromotionPost,
        {
          "postId": postId,
          "userReach": totalAudience.toString(),
          "days": duration.toString(),
          "redirectTo": redirectionType.toString(),
          "redirection": redirectionUrl.toString()
        },
        userToken);
    print(response);
    if (response != "error") {
      if (response["promotionAdded"].toString() == "true") {
        isProcessing = false;
        update();
        Get.to(() => PaymentProcessPageScreen(promotionDetails: response,price:budget ,));
      } else {
        Get.snackbar("Some error occured", "please try again");
        isProcessing = false;
        update();
      }
    } else if (response == "error") {
      Get.snackbar("Some error occured", "please try again");
      isProcessing = false;
      update();
    }
  }
}
