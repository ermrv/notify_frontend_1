import 'dart:io';
import 'dart:typed_data';

import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/SingleImagePickerModule/views/SingleImagePicker.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/SingleVideoPickerModule/views/SingleVideoPicker.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/views/UserProfileScreen.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ContestParticipationPostUploadScreenController extends GetxController {
  String contestId;
  String contestName;
  String contestContentType = "image";
  File contestPostFile;
  File videoThumbnail;

  TextEditingController discriptionEditingController, tagsEditingController;

  @override
  void onInit() {
    discriptionEditingController = TextEditingController();
    tagsEditingController = TextEditingController();
    super.onInit();
  }

  getFile() async {
    File _temp;
    if (contestContentType == "image") {
      _temp = await Get.to(() => SingleImagePicker());
      if (_temp != null) {
        contestPostFile = _temp;
      }
    } else if (contestContentType == "video") {
      _temp = await Get.to(() => SingleVideoPicker());
      if (_temp != null) {
        contestPostFile = _temp;
      }
    }

    update();
  }

  ///produce the thumbnail of a videofile
  Future<Uint8List> getThumbnail() async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: contestPostFile.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth:
          0, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 75,
    );
    return uint8list;
  }

  ///handle post button click
  handlePostButtonClick() async {
    if (contestPostFile != null) {
      List<File> _files = [];
      _files.add(contestPostFile);
      var request = http.MultipartRequest(
          "POST", Uri.parse(ApiUrlsData.contestParticipatePostUpload));
      request.headers["authorization"] = "Bearer " + userToken;
      request.headers["Content-type"] = "multipart/form-data";
      request.fields['description'] = discriptionEditingController.text;
      request.fields['contestId'] = contestId;
      request.fields["postContentType"] = contestContentType;
      for (File i in _files) {
        request.files.add(await http.MultipartFile.fromPath(
          "postFile",
          i.path,
          contentType: MediaType(
              contestContentType.toString(), i.path.split(".").last.toString()),
        ));
      }
      var response = await request.send();
      if (response.statusCode == 200) {
        print(response);
        // Get.offUntil(GetPageRoute(page: () => UserProfileScreen()),(route)=>Get.until((route) =>Get.isDialogOpen);
        Get.off(() => UserProfileScreen(profileOwnerId: PrimaryUserData.primaryUserData.userId,));
      } else {
        print(response.statusCode);
      }
    } else {
      Get.dialog(
        AlertDialog(
          title: Text("Select a file"),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Okay"))
          ],
        ),
      );
    }
  }
}
