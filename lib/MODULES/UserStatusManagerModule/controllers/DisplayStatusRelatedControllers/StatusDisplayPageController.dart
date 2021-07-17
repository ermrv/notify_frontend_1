import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:get/get.dart';

class StatusDisplayPageController extends GetxController {
  List statusData;

  addStatusComment(String statusId, String comment) async {
    var response = await ApiServices.postWithAuth(ApiUrlsData.addStatusComments,
        {"statusId": statusId, "comment": comment}, userToken);

    if (response != "error") {
    } else {
      print("error");
    }
  }
}
