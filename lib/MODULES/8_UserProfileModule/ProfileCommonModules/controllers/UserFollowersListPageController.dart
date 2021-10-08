import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class UserFollowersListPageController extends GetxController {
  String profileId;
  List data = [];
  bool requestProcessed = false;

  initialise() {
    getData();
  }

  getData() async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.userFollowers, {"userId":profileId}, userToken.toString());
    if (response == "error") {
      print("some error occured");
    } else {
      requestProcessed = true;
      data.addAll(response);
      update();
    }
  }
}
