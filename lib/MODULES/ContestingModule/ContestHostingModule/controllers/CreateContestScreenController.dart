import 'dart:io';
import 'dart:typed_data';

import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/AddPostModule/MediaCompressorModule/ImageCompressor.dart';
import 'package:MediaPlus/MODULES/AddPostModule/SingleImagePickerModule/views/SingleImagePicker.dart';
import 'package:MediaPlus/MODULES/ContestingModule/ContestHostingModule/views/ContestHostingHistoryScreen.dart';
import 'package:MediaPlus/MODULES/UserAuthModule/userAuthVariables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class CreateContestScreenController extends GetxController {
  bool isUploading = false;
  File contestImage;
  int prizeCoins = 200;
  String contestEndDate;

  Uint8List compressedContestImage;
  TextEditingController contestNameController,
      contestEndDateController,
      contestDescriptionController,
      contestRulesController;

  @override
  void onInit() {
    contestNameController = TextEditingController();
    contestEndDateController = TextEditingController();
    contestDescriptionController = TextEditingController();
    contestRulesController = TextEditingController();

    contestEndDateController.text =
        DateTime.now().add(Duration(days: 1)).toString();

    super.onInit();
  }

  getContestImage() async {
    File temp = await Get.to(() => SingleImagePicker());
    if (temp != null) {
      contestImage = temp;
    }

    update();
  }

  getPrizeCoins() async {
    prizeCoins = await Get.bottomSheet(Container(
      height: 300.0,
      child: Scaffold(),
    ));

    print(prizeCoins);
  }

  postContestHandler() async {
    print("object");
    //check if required fields are not null
    if (contestNameController.text != null &&
        contestDescriptionController != null &&
        contestEndDate != null &&
        contestRulesController.text != null &&
        contestImage != null) {
      //get the compressed image
      List<Uint8List> _temp =
          await ImageCompressor.compressImages([contestImage]);
      compressedContestImage = _temp[0];
      print(compressedContestImage.lengthInBytes);
      //call the function upload the data
      uploadContestData();
    } else {
      Get.dialog(AlertDialog(
        title: Text("All Fields are mandatory!"),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Okay"))
        ],
      ));
    }
  }

  uploadContestData() async {
    var request =
        http.MultipartRequest("POST", Uri.parse(ApiUrlsData.createContest));
    request.headers["authorization"] = "Bearer " + userToken;
    request.headers["Content-type"] = "multipart/form-data";
    request.fields['contestName'] = contestNameController.text;
    request.fields['description'] = contestDescriptionController.text;
    request.fields['contestRules'] = [contestRulesController.text].toString();
    request.fields['coins'] = "200";
    request.fields['endsOn'] = contestEndDate;
    request.files.add(http.MultipartFile.fromBytes(
      "poster",
      compressedContestImage,
      filename: contestImage.path,
      contentType:
          MediaType("image", contestImage.path.split(".").last.toString()),
    ));
    var response = await request.send();
    final strResponse = await response.stream.bytesToString();
    print(response.statusCode);
    if (response.statusCode == 200) {
      isUploading = false;
      Get.snackbar("Uploaded", "Task Completed");
      update();
    }else{
      isUploading = false;
      Get.snackbar("Error", "Error Occured");
      update();
    }
  }
}
