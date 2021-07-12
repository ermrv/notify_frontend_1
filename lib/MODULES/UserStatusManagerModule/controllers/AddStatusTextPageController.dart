import 'dart:io';
import 'dart:typed_data';

import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/AddPostModule/MediaCompressorModule/ImageCompressor.dart';
import 'package:MediaPlus/MODULES/AddPostModule/MediaCompressorModule/VideoCompressor.dart';
import 'package:MediaPlus/MODULES/MainNavigationModule/views/MainNavigation.dart';
import 'package:MediaPlus/MODULES/UserAuthModule/userAuthVariables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AddStatusTextPageController extends GetxController {
  List<File> imageFiles;
  List<File> videoFiles;

  List<Uint8List> compressedImageFiles = [];
  List<Uint8List> compressedVideoFiles = [];

  bool isUploading = false;
  Future<Uint8List> getVideoThumbnail(File videoFile) async {
    Uint8List thumbdata = await VideoThumbnail.thumbnailData(
      video: videoFile.path,
      quality: 70,
      maxHeight: 0,
      maxWidth: 0,
    );
    return thumbdata;
  }

  //post uploading
  postHandler() async {
    isUploading = true;
    update();
    if (imageFiles.length != 0) {
      compressedImageFiles
          .addAll(await ImageCompressor.compressImages(imageFiles));
    }
    if (videoFiles.length != 0) {
      for (File i in videoFiles) {
        compressedVideoFiles.add(await VideoCompressor.compressVideo(i));
      }
    }

    _uploadFiles();
  }

  _uploadFiles() async {
    var request =
        http.MultipartRequest("POST", Uri.parse(ApiUrlsData.addStatus));
    request.headers["authorization"] = "Bearer " + userToken;
    request.headers["Content-type"] = "multipart/form-data";

    //adding images
    for (Uint8List i in compressedImageFiles) {
      int index = compressedImageFiles.indexOf(i);
      print(index);
      request.fields['statusText'] = "Status text for image file";
      request.files.add(http.MultipartFile.fromBytes("statusFile", i.toList(),
          filename: imageFiles[index].path,
          contentType: MediaType(
              "image", imageFiles[index].path.split(".").last.toString())));
    }
    for (Uint8List i in compressedVideoFiles) {
      int index = compressedVideoFiles.indexOf(i);
      print(index);
      request.fields['statusText'] = "Status text for video file";
      request.files.add(http.MultipartFile.fromBytes("statusFile", i.toList(),
          filename: imageFiles[index].path,
          contentType: MediaType(
              "video", imageFiles[index].path.split(".").last.toString())));
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      print(response);
      isUploading = false;
      update();

      /// Get.offUntil(GetPageRoute(page: () => UserProfileScreen()),(route)=>Get.until((route) =>Get.isDialogOpen);
      Get.off(() => MainNavigationScreen());
    } else {
      isUploading = false;
      update();
      print(response.statusCode);
    }
  }
}
