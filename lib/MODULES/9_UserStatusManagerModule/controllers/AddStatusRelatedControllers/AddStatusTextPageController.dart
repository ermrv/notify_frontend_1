import 'dart:io';
import 'dart:typed_data';

import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/MediaCompressorModule/ImageCompressor.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/MediaCompressorModule/VideoCompressor.dart';
import 'package:MediaPlus/MODULES/14_MainNavigationModule/views/MainNavigation.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
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

    _uploadFiles();
  }

  _uploadFiles() async {
    FlutterUploader _flutterUploader = FlutterUploader();
    List<FileItem> _files = [];
    for (File i in imageFiles) {
      _files.add(
        FileItem(
            fieldname: "statusFile",
            filename: i.path,
            savedDir: (i.path).split("/")[0].toString()),
      );
    }
    for (File i in videoFiles) {
      _files.add(
        FileItem(
            fieldname: "statusFile",
            filename: i.path,
            savedDir: (i.path).split("/")[0].toString()),
      );
    }
    final taskId = await _flutterUploader.enqueue(
      url: ApiUrlsData.addStatus,
      method: UploadMethod.POST,
      headers: {
        "authorization": "Bearer " + userToken,
        "Content-type": "multipart/form-data"
      },
      data: {
        "statusText": "okay",
      },
      files: _files,
      showNotification: true,
      tag: "status upload",
    );

    ///navigate to the news feed screen
    Get.offAll(() => MainNavigationScreen(
          tabNumber: 0,
        ));
  }
}
