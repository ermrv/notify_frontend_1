import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class UserFollowingsListPageController extends GetxController {
  String profileId;
  List data = [];
  bool requestProcessed = false;

  initialise() {
    getData();
  }

  getData() async {
    var response = await ApiServices.postWithAuth(ApiUrlsData.userFollowings,
        {"userId": profileId}, userToken.toString());
    if (response == "error") {
      print("some error occured");
    } else {
      requestProcessed = true;
      data.addAll(response);
      update();
    }
  }
}
