import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:get/get.dart';

class StatusCommentsPageController extends GetxController {
  List commentsData;
  String statusId;

  initialise() {
    _getCommentsData();
  }

  _getCommentsData() async {
    var response = ApiServices.postWithAuth(
        ApiUrlsData.statusComments, {"statusId": statusId}, userToken);

    if (response == "error") {
      print("error");
    } else {
      print(response);
    }
  }
}
