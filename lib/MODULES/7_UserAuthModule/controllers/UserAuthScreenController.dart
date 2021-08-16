import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/views/GetUserData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/views/LoginScreen.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/NotificationServices/NotificationServices.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

class UserAuthScreenController extends GetxController {
  String _userToken;

  

  @override
  onReady() {
    super.onReady();
    _navigator();
  }

  ///get the user token if avilable in the local storage
  String getUserToken() {
    String token;
    if (_userToken == null) {
      final storage = GetStorage();
      token = storage.read("userToken");
      _userToken = token;
      update();
    } else {
      token = _userToken;
    }
    print(token);
    return token;
  }

  ///navigator based on the token availability of the user token
  ///
  _navigator() {
    String _token = getUserToken();
    if (_token == null) {
      Get.offAll(() => LoginScreen());
    } else {
      userToken = _token;
      Get.offAll(GetUserData());
    }
  }
}
