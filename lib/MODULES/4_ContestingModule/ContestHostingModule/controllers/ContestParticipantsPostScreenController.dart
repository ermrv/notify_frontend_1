import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ContestParticipantsPostScreenController extends GetxController {
  List contestPosts;
  String contestId;

  getData() async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.contestPosts, {"contestId": contestId}, userToken);
    if (response != null) {
      contestPosts = response;
      print(response);
    } else {
      Get.snackbar("title", "message");
    }

    update();
  }
}
