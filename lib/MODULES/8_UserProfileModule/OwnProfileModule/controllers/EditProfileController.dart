import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/14_MainNavigationModule/views/MainNavigation.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/UserProfileScreen.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class EditProfileController extends GetxController {
  bool isUpdating = false;
  TextEditingController nameEditingController,
      userNameIdEdititngController,
      bioEditingController;

  @override
  onInit() {
    nameEditingController = TextEditingController();
    nameEditingController.text = PrimaryUserData.primaryUserData.name;
    userNameIdEdititngController = TextEditingController();
    userNameIdEdititngController.text =
        PrimaryUserData.primaryUserData.userName;
    bioEditingController = TextEditingController();
    bioEditingController.text = PrimaryUserData.primaryUserData.bio;
    super.onInit();
  }

  ///edited data of the form having name email etc
  sendEditedData() async {
    isUpdating = true;
    update();
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.userProfileDetailsUpdate,
        {"name": nameEditingController.text, "bio": bioEditingController.text},
        userToken);
    if (response == "error") {
      Get.snackbar("Error Occured", "please try again later");
      isUpdating = false;
      update();
    } else {
      PrimaryUserData.primaryUserData.setName(response["userData"]["name"]);
      PrimaryUserData.primaryUserData.setBio(response["userData"]["bio"]);
      PrimaryUserData.primaryUserData.setUserName(response["userData"]["userName"]);
      isUpdating = false;
      update();

      Get.offAll(MainNavigationScreen(
        tabNumber: 4,
      ));
    }
  }
}
