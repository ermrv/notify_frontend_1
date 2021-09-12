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

class ShowCoverPicController extends GetxController {
  File coverPicFile;
  bool isUpdating = false;

  @override
  void onInit() {
    super.onInit();
  }

  ///get the selected profile pic
  ///
  getCoverPicFile() async {
    coverPicFile = await Get.to(SingleImagePicker(
      intendedFor: "coverPic",
    ));
    update();
  }

  ///method for updating the selected profile pic
  ///
  updateCoverPic() async {
    if (coverPicFile == null) {
      return null;
    }

    isUpdating = true;
    update();
    var request = http.MultipartRequest(
        "POST", Uri.parse(ApiUrlsData.userCoverPicUpdate));
    request.headers["authorization"] = "Bearer " + userToken;
    request.files.add(await http.MultipartFile.fromPath(
      "image",
      coverPicFile.path,
      contentType: MediaType("image", coverPicFile.path.split(".").last),
    ));
    var streamedResponse = await request.send();
    if (streamedResponse.statusCode == 200) {
      var response = await http.Response.fromStream(streamedResponse);
      var data = json.decode(response.body);
      PrimaryUserData.primaryUserData.setCoverPic(data["userData"]["coverPic"]);
      isUpdating = false;
      update();
      Get.back();
    } else {
      print(streamedResponse.statusCode);
      isUpdating = false;
      update();
    }
  }
}
