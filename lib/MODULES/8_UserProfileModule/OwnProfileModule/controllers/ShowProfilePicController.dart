import 'dart:convert';
import 'dart:io';

import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/SingleImagePickerModule/views/SingleImagePicker.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ShowProfilePicController extends GetxController {
  bool isUpdating = false;
  File profilePicFile;

  @override
  void onInit() {
    super.onInit();
  }

  ///get the selected profile pic
  ///
  getProfilePicFile() async {
    profilePicFile = await Get.to(SingleImagePicker(
      intendedFor: "profilePic",
    ));
    update();
  }

  ///method for updating the selected profile pic
  ///
  updateProfilePic() async {
    if (profilePicFile == null) {
      return null;
    }

    isUpdating = true;
    update();
    var request = http.MultipartRequest(
        "POST", Uri.parse(ApiUrlsData.userProfilePicUpdate));
    request.headers["authorization"] = "Bearer " + userToken;
    request.files.add(await http.MultipartFile.fromPath(
      "image",
      profilePicFile.path,
      contentType: MediaType("image", profilePicFile.path.split(".").last),
    ));
    var streamedResponse = await request.send();
    if (streamedResponse.statusCode == 200) {
      var response = await http.Response.fromStream(streamedResponse);
      var data = json.decode(response.body);
      PrimaryUserData.primaryUserData
          .setProfilePic(data["userData"]["profilePic"]);
      isUpdating = false;
      update();
      Get.back();
    }
  }
}
