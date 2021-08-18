import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:get/get.dart';
  
class PromotedPostActionSelectorController extends GetxController {
  String postId;
  int totalAudience;
  int duration;
  int budget;

  String redirectionType;
  String redirectionUrl;

  sendData() async {
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
  }
}
