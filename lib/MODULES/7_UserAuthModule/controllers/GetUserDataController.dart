import 'dart:convert';
import 'dart:io';

import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/14_MainNavigationModule/views/MainNavigation.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/LocalDataFiles.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/NotificationServices/NotificationServices.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:path_provider/path_provider.dart';

///uses [PrimaryUserDataMofel] from profile module to set the users data
class GetUserDataController extends GetxController {
  var rcvdData;

  @override
  onReady() {
    _initialiseFileSystem();
  }

  ///creates the files for local storage of user data
  _initialiseFileSystem() async {
    await LocalDataFiles.initialiseLocalFilesPath();
    getData();
  }

  getData() async {
    try {
      rcvdData = json.decode(
          await File(LocalDataFiles.userBasicDataFilePath).readAsString());

      ///naviagting to the [MainNavigationScreen]
      ///
      ///end of the [7_AddPostModule]
      if (rcvdData != null) {
        await PrimaryUserData.primaryUserData.jsonToModel(rcvdData);
        Get.offAll(() => MainNavigationScreen());
      }
    } catch (e) {
      print(e);
      print("getting user basic data");
      String fcmToken = await NotificationServices.getFcmToken();
      var response = await ApiServices.postWithAuth(
          ApiUrlsData.appStart, {"fcmToken": fcmToken}, userToken.toString());
      if (response == "error") {
        Get.snackbar("Error", "Cannot get the data");
      } else {
        rcvdData = response;
        print(rcvdData);
        PrimaryUserData.primaryUserData.jsonToModel(response);

        //write the data to local file
        await File(LocalDataFiles.userBasicDataFilePath)
            .writeAsString(json.encode(response), mode: FileMode.write)
            .then((value) => Get.offAll(() => MainNavigationScreen()));

        ///naviagting to the [MainNavigationScreen]
        ///
        ///end of the [7_AddPostModule]

      }
    }
  }
}
