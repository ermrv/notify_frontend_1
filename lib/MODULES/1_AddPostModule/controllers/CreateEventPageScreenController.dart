import 'dart:io';
import 'dart:typed_data';

import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/MediaCompressorModule/ImageCompressor.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/SingleImagePickerModule/views/SingleImagePicker.dart';
import 'package:MediaPlus/MODULES/4_ContestingModule/ContestHostingModule/views/ContestHostingHistoryScreen.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/views/UserProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class CreateEventPageScreenController extends GetxController {
  bool isUploading = false;
  File eventImage;
  double eventImageAspectRatio = 4 / 3;
  String eventStartDate;
  String eventEndDate;

  Uint8List compressedEventImage;

  TextEditingController eventNameController,
      eventStartDateController,
      eventDescriptionController;

  @override
  void onInit() {
    eventNameController = TextEditingController();
    eventStartDateController = TextEditingController();
    eventDescriptionController = TextEditingController();

    eventStartDateController.text = DateTime.now().toString();

    super.onInit();
  }

  getEventImage() async {
    File temp = await Get.to(() => SingleImagePicker());
    if (temp != null) {
      eventImage = temp;
      var decodeImage = await decodeImageFromList(temp.readAsBytesSync());
      eventImageAspectRatio = decodeImage.width / decodeImage.height;
    }

    update();
  }

  postEventHandler() async {
    isUploading = true;
    update();
    //check if required field is not null
    if (eventNameController.text != null &&
        eventStartDate != null &&
        eventImage != null) {
      //get the compressed image
      List<Uint8List> _temp =
          await ImageCompressor.compressImages([eventImage]);
      compressedEventImage = _temp[0];
      print(compressedEventImage.lengthInBytes);
      //call the function upload the data
      uploadEventData();
    } else {
      isUploading = false;
      update();
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

  //upload the data
  uploadEventData() async {
    var request =
        http.MultipartRequest("POST", Uri.parse(ApiUrlsData.addEventPost));
    request.headers["authorization"] = "Bearer " + userToken;
    request.headers["Content-type"] = "multipart/form-data";
    request.fields['eventName'] = eventNameController.text;
    request.fields['description'] = eventDescriptionController.text;
    request.fields['startsOn'] = eventStartDate;
    request.fields["endsOn"] = eventEndDate;
    request.files.add(http.MultipartFile.fromBytes(
      "poster",
      compressedEventImage,
      filename: eventImage.path,
      contentType:
          MediaType("image", eventImage.path.split(".").last.toString()),
    ));
    var response = await request.send();
    final strResponse = await response.stream.bytesToString();
    print(response.statusCode);
    if (response.statusCode == 200) {
      isUploading = false;
      Get.snackbar("Uploaded", "Task Completed");
      update();
      Get.to(() => UserProfileScreen(
            profileOwnerId: PrimaryUserData.primaryUserData.userId,
          ));
    } else {
      isUploading = false;
      Get.snackbar("Error", "Error Occured");
      update();
    }
  }
}
