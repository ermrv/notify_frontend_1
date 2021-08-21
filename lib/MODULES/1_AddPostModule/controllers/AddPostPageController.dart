import 'dart:io';
import 'dart:typed_data';

import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/14_MainNavigationModule/views/MainNavigation.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/MediaCompressorModule/ImageCompressor.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/MediaCompressorModule/VideoCompressor.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/AddPostScreenBottomSheet.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/ImagesGridDisplay.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/SelectedImagesDisplayTemplates/DuobleImageHorizontalDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/SelectedImagesDisplayTemplates/DuobleImageVerticalDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/SelectedImagesDisplayTemplates/ImageCarouselDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/SelectedImagesDisplayTemplates/MultiImageHorizontalDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/SelectedImagesDisplayTemplates/MultiImageVerticalDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/SelectedImagesDisplayTemplates/SingleImageDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/VideoGridDisplay.dart';

import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/views/UserProfileScreen.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart' as dio;
import 'package:workmanager/workmanager.dart';

class AddPostPageController extends GetxController {
  //to show the upload task
  bool isUploading = false;
  bool isUploaded = false;
  bool isError = false;
  //
  bool showBottomNavbar = true;
  double aspectRatio;

  TextEditingController textEditingController;
  String location;
  File videoFile;
  Uint8List videoThumbImage;
  List<File> imageFiles;
  String templateType;

  FlutterUploader _flutterUploader;
  //compressed images and videos in Uint8Lst
  //ready to be uploaded
  List<Uint8List> compressedImages;
  Uint8List compressedVideo;
  Uint8List compressedThumbnail;

  @override
  void onInit() {
    textEditingController = TextEditingController();
    _flutterUploader = FlutterUploader();
    super.onInit();
  }

  @override
  void onReady() {
    // showBottomSheet();
    super.onReady();
  }

  showBottomSheet() {
    Get.bottomSheet(AddPostScreenBottomSheet(), elevation: 0.0);
  }

  ///to select image files
  getImageFiles() async {
    Map<String, dynamic> _imagesData = await Get.to(() => ImagesGridDisplay());
    if (_imagesData != null) {
      imageFiles = _imagesData["files"];
      templateType = _imagesData["templateType"];
      aspectRatio = _imagesData["aspectRatio"];
      showBottomNavbar = false;
      print(aspectRatio);
      update();
    }
  }

  ///to selecet video files
  getVideoFile() async {
    Map<String, dynamic> _temp = await Get.to(() => VideosGridDisplay());
    if (_temp != null) {
      videoFile = _temp["file"];
      aspectRatio = _temp["aspectRatio"];
      videoThumbImage = _temp["thumbData"];
      showBottomNavbar = false;
      update();
    }
  }

  //remove selected files
  removeFiles() {
    videoFile = null;
    imageFiles = null;
    videoThumbImage = null;
    aspectRatio = null;
    showBottomNavbar = true;
    templateType = null;

    ///all compressed images and videoes are set to null
    compressedImages = null;
    compressedVideo = null;
    compressedThumbnail = null;
    update();
  }

  ///image display template
  Widget getTemplate(String templateType) {
    if (imageFiles.length == 1) {
      return SingleImageDisplayTemplate(
        imageFile: imageFiles[0],
        aspectRatio: aspectRatio,
      );
    } else {
      switch (templateType.toLowerCase()) {
        case "imagecarousel":
          return ImageCarouselDisplayTemplate(
            files: imageFiles,
            aspectRatio: aspectRatio,
          );
          break;
        case "vertical":
          if (imageFiles.length == 2) {
            return DoubleImageVerticalDisplayTemplate(
              files: imageFiles,
            );
          } else {
            return MultiImageVerticalDisplayTemplate(
              files: imageFiles,
            );
          }

          break;
        case "horizontal":
          if (imageFiles.length == 2) {
            return DoubleImageHorizontalDisplayTemplate(
              files: imageFiles,
            );
          } else {
            return MultiImageHorizontalDisplayTemplate(
              files: imageFiles,
            );
          }

          break;
        default:
      }
    }
  }

  ///uploading data
  uploadData() async {
    isUploading = true;
    if (videoFile == null && imageFiles != null) {
      List<Uint8List> _temp = await ImageCompressor.compressImages(imageFiles);
      for (Uint8List i in _temp) {
        Get.snackbar((i.lengthInBytes / 1000).toString(), "message");
      }
      compressedImages = _temp;
      uploadImages();
    }

    if (videoFile != null && imageFiles == null) {
      // Uint8List a = await videoFile.readAsBytes();
      // String originalSize = a.lengthInBytes.toString();
      compressedVideo = await VideoCompressor.compressVideo(videoFile);

      // Get.dialog(Card(
      //   child: Column(
      //     children: [
      //       Text("compressed  " + originalSize),
      //       Text("original  " + compressedVideo.lengthInBytes.toString()),
      //       Text((compressedVideo.lengthInBytes / int.parse(originalSize))
      //           .toString())
      //     ],
      //   ),
      // ));
      uploadVideo();
    }

    if (videoFile == null &&
        imageFiles == null &&
        textEditingController.text != null) {
      uploadTextPost();
    } else if (videoFile == null &&
        imageFiles == null &&
        textEditingController.text == null) {
      isUploading = false;
    }

    update();
  }

  //.......................to upload the text post...........................
  uploadTextPost() async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.addTextPost,
        {"description": textEditingController.text, "postType": "text"},
        userToken);

    if (response != "error") {
      ///navigate to the news feed screen
      Get.offAll(() => MainNavigationScreen(
            tabNumber: 0,
          ));
    }
  }

  ///....................to upload the  images.........................
  uploadImages() async {
    List<FileItem> _imageFiles = [];
    for (File i in imageFiles) {
      _imageFiles.add(
        FileItem(
            fieldname: "postFile",
            filename: i.path,
            savedDir: (i.path).split("/")[0].toString()),
      );
    }
    final taskId = await _flutterUploader.enqueue(
      url: ApiUrlsData.addImagePost,
      method: UploadMethod.POST,
      headers: {
        "authorization": "Bearer " + userToken,
        "Content-type": "multipart/form-data"
      },
      data: {
        "description": textEditingController.text,
        "templateType": templateType,
        "postType": "images"
      },
      files: _imageFiles,
      showNotification: true,
      tag: "image upload",
    );

    ///navigate to the news feed screen
    Get.offAll(() => MainNavigationScreen(
          tabNumber: 0,
        ));
  }

  ///....................to upload video................................
  uploadVideo() async {
    final taskId = await _flutterUploader.enqueue(
      url: ApiUrlsData.addImagePost,
      method: UploadMethod.POST,
      headers: {
        "authorization": "Bearer " + userToken,
        "Content-type": "multipart/form-data"
      },
      data: {
        "description": textEditingController.text,
        "aspectRatio": aspectRatio.toString(),
        "postType": "video"
      },
      files: [
        FileItem(
            filename: videoFile.path,
            savedDir: videoFile.path.split("/")[0],
            fieldname: "postFile")
      ],
      showNotification: true,
      tag: "video upload",
    );

    ///navigate to the news feed screen
    Get.offAll(() => MainNavigationScreen(
          tabNumber: 0,
        ));
  }
}
