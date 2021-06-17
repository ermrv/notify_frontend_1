import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/MainNavigationModule/views/MainNavigation.dart';
import 'package:MediaPlus/MODULES/UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

///uses [PrimaryUserDataMofel] from profile module to set the users data
class GetUserDataController extends GetxController {
  var rcvdData;

  @override
  onReady() {
    getData();
  }

  getData() async {
    print("token" + userToken.toString());
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.appStart, {}, userToken.toString());
    if (response == "error") {
      Get.snackbar("Error", "Cannot get the data");
    } else {
      rcvdData = response;
      //variable
      PrimaryUserData.primaryUserData.jsonToModel(response);
      print(rcvdData);

      ///naviagting to the [MainNavigationScreen]
      ///
      ///end of the [UserAuthModule]
      Get.offAll(() => MainNavigationScreen());
    }
  }
}
