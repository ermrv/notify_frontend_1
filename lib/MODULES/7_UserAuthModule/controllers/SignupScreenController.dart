import 'dart:io';
import 'package:MediaPlus/MODULES/1_AddPostModule/SingleImagePickerModule/views/SingleImagePicker.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/views/GetUserData.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/LocalDataFiles.dart';
import 'package:get/get.dart';
import 'package:get_mac/get_mac.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';

import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class SignUpScreenController extends GetxController {
  TextEditingController nameEditingController, passwordEditingController;
  String newUserRegName;

  String newUserRegPassword;
  File profilePic;
  var rcvdData;

  bool isProcessing = false;

  @override
  void onInit() {
    nameEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
    if (newUserRegName != null) {
      nameEditingController.text = newUserRegName;
    }
    if (newUserRegPassword != null) {
      passwordEditingController.text = newUserRegPassword;
    }
    super.onInit();
  }

  handleFileReturned() async {
    profilePic = await Get.to(() => SingleImagePicker(
          intendedFor: "profilePic",
        ));
    if (profilePic != null) {
      update();
    }
  }

  ///sending user signup data to the server
  ///
  ///if profilePic is selected,[_updateProfilePic] will be called by this function
  sendUserData() async {
    isProcessing = true;
    update();
    if (nameEditingController.text == null ||
        nameEditingController.text == "") {
      isProcessing = false;
      update();
      Get.snackbar("Please Enter your name", "Please Enter your name");
    } else {
      //if profile pic is selected call _updateProfilePic()
      if (profilePic != null) {
        int statusCode = await _updateProfilePic();
        //if profile pic is uploaded successfully only then send the rest of the data
        if (statusCode == 200) {
          String name = nameEditingController.text;
          String password = passwordEditingController.text;

          var response = await ApiServices.postWithAuth(
              ApiUrlsData.userRegistration,
              {"name": name, "password": password, "email": "dfadf@gmail.com"},
              unregisteredUserToken);
          if (response == "error") {
            isProcessing = false;
            update();
            Get.snackbar("Cannot process the request", "try again");
          } else {
            rcvdData = response;
            userToken = unregisteredUserToken;
            _navigator();
          }
        } else {
          isProcessing = false;
          update();
          Get.snackbar("Cannot process the request", "try again");
        }
      } else {
        String name = nameEditingController.text;
        // String password = passwordEditingController.text;

        var response = await ApiServices.postWithAuth(
            ApiUrlsData.userRegistration,
            {
              "name": name,
            },
            unregisteredUserToken);
        if (response == "error") {
          isProcessing = false;
          update();
          Get.snackbar("Cannot process the request", "try again");
        } else {
          rcvdData = response;
          userToken = unregisteredUserToken;

          print(rcvdData);
          _navigator();
        }
      }
    }
  }

  ///method for updating the selected profile pic
  ///
  Future<int> _updateProfilePic() async {
    var request = http.MultipartRequest(
        "POST", Uri.parse(ApiUrlsData.userProfilePicUpdate));
    request.headers["authorization"] = "Bearer " + unregisteredUserToken;
    request.files.add(await http.MultipartFile.fromPath(
      "image",
      profilePic.path,
      contentType: MediaType("image", profilePic.path.split(".").last),
    ));
    var response = await request.send();
    return response.statusCode;
  }

  _navigator() {
    if (rcvdData["login"].toString() == "true" &&
        rcvdData["registered"].toString() == "true") {
      final storage = GetStorage();
      storage.write("userToken", userToken);
      // _sendMacAddress();

      Get.offAll(() => GetUserData());
    } else {
      Get.defaultDialog(radius: 5.0, title: "Ooops! something went wrong");
    }
  }
}
