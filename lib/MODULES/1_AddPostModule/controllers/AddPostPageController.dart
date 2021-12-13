import 'dart:io';
import 'dart:typed_data';

import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/14_MainNavigationModule/views/MainNavigation.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/AddPostScreenBottomSheet.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/ImagesGridDisplay.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/SelectedImagesDisplayTemplates/DuobleImageHorizontalDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/SelectedImagesDisplayTemplates/DuobleImageVerticalDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/SelectedImagesDisplayTemplates/ImageCarouselDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/SelectedImagesDisplayTemplates/MultiImageHorizontalDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/SelectedImagesDisplayTemplates/MultiImageVerticalDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/SelectedImagesDisplayTemplates/SingleImageDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/VideoGridDisplay.dart';

import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OwnProfileModule/controllers/OwnProfilePageScreenController.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AddPostPageController extends GetxController {
  //to show the upload task
  bool isUploading = false;
  bool isUploaded = false;
  bool isError = false;

  bool allowCommenting = true;
  bool allowSharing = true;

  //
  bool showBottomNavbar = true;
  double aspectRatio;

  TextEditingController textEditingController;
  String location;
  File videoFile;
  Uint8List videoThumbImage;
  List<File> imageFiles;
  String templateType;
  //compressed images and videos in Uint8Lst
  //ready to be uploaded
  Uint8List compressedThumbnail;

  ///autosuggestions
  bool showSuggestions = false;
  List tagsSuggestions;
  List userSuggestions;

  @override
  void onInit() {
    textEditingController = TextEditingController();
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

  //commenting privacy update
  updateCommentPrivacy(bool value) {
    allowCommenting = value;
    update();
  }

  //sharing privacy update
  updateSharingPrivacy(bool value) {
    allowSharing = value;
    update();
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
    if (imageFiles != null && videoFile == null) {
      uploadImages();
    } else if (videoFile != null && imageFiles == null) {
      uploadVideo();
    } else if (videoFile == null &&
        imageFiles == null &&
        textEditingController.text != "") {
      uploadTextPost();
    } else if (videoFile == null &&
        imageFiles == null &&
        textEditingController.text == "") {
      isUploading = false;
      Get.snackbar("Nothing to post", "Nothing to post");
    }

    update();
  }

  //.......................to upload the text post...........................
  uploadTextPost() async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.addTextPost,
        {
          "description": textEditingController.text,
          "postType": "text",
          "commentOption": allowCommenting.toString(),
          "sharingOption": allowSharing.toString(),
        },
        userToken);

    if (response != "error") {
      try {
        final controller = Get.find<OwnProfilePageScreenController>();
        controller.getRecentPostsData();
      } catch (e) {}
      Get.offAll(MainNavigationScreen(
        tabNumber: 0,
      ));
    }
  }

  ///....................to upload the  images.........................
  uploadImages() async {
    FlutterUploader _flutterImageUploader = FlutterUploader();
    List<FileItem> _imageFiles = [];
    for (File i in imageFiles) {
      _imageFiles.add(
        FileItem(
            fieldname: "postFile",
            filename: i.path,
            savedDir: (i.path).split("/")[0].toString()),
      );
    }
    final taskId = await _flutterImageUploader.enqueue(
      url: ApiUrlsData.addImagePost,
      method: UploadMethod.POST,
      headers: {
        "authorization": "Bearer " + userToken,
        "Content-type": "multipart/form-data"
      },
      data: {
        "description": textEditingController.text,
        "templateType": templateType,
        "postType": "images",
        "commentOption": allowCommenting.toString(),
        "sharingOption": allowSharing.toString(),
      },
      files: _imageFiles,
      showNotification: true,
      tag: "image upload",
    );

    _flutterImageUploader.result.listen((result) {
      if (result.status == UploadTaskStatus.complete) {
        try {
          final controller = Get.find<OwnProfilePageScreenController>();
          controller.getRecentPostsData();
        } catch (e) {}
      }
    });

    Get.offAll(MainNavigationScreen(
      tabNumber: 0,
    ));
  }

  ///....................to upload video................................
  uploadVideo() async {
    String filePath = videoFile.path;
    List _temp = filePath.split("/").toList();
    String savedDir = _temp.getRange(0, _temp.length - 1).join("/").toString();
    print(savedDir);
    FlutterUploader _flutterVideoUploader = FlutterUploader();
    final taskId = await _flutterVideoUploader.enqueue(
      url: ApiUrlsData.addVideoPost,
      method: UploadMethod.POST,
      headers: {
        "authorization": "Bearer " + userToken,
        "Content-type": "multipart/form-data"
      },
      data: {
        "description": textEditingController.text,
        "aspectRatio": aspectRatio.toString(),
        "postType": "video",
        "commentOption": allowCommenting.toString(),
        "sharingOption": allowSharing.toString(),
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
    _flutterVideoUploader.result.listen((result) {
      if (result.status == UploadTaskStatus.complete) {
        try {
          final controller = Get.find<OwnProfilePageScreenController>();
          controller.getRecentPostsData();
        } catch (e) {}
      }
    });

    ///navigate to the news feed screen
    Get.offAll(MainNavigationScreen(
      tabNumber: 0,
    ));
  }
//---------------------------------------------user and tags suggestins related--------------------------------

  ///string parser for tagging and mentioning
  stringParser(String text) {
    List<String> words;
    words = text.split(" ").toList();
    String lastWord = words.last.trim();
    String firstCharacter = "";
    try {
      firstCharacter = lastWord.characters.first;
    } catch (e) {}

    if (firstCharacter == "#") {
      String query = lastWord.replaceFirst("#", "");
      showSuggestions = true;
      update();
      _getTagsSuggestions(query);
    } else if (firstCharacter == "@") {
      String query = lastWord.replaceFirst("@", "");
      showSuggestions = true;
      update();
      if (query.characters.length >= 1) {
        _getUserSuggestions(query);
      }
    } else {
      showSuggestions = false;
      update();
    }
  }

  ///get the user suggestions from the server
  _getUserSuggestions(String query) async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.userSuggestions, {"query": query}, userToken);
    if (response != "error") {
      print(response);
      userSuggestions = response["search-results"];
      update();
    }
  }

  ///get the tag suggestions from the server
  _getTagsSuggestions(String query) async {}

  ///mention the the selected name to the text
  includeName(String name) {
    userSuggestions = null;
    showSuggestions = false;
    List<String> _initialTextList = textEditingController.text.split(" ");
    String _initialText =
        _initialTextList.sublist(0, _initialTextList.length - 1).join(" ");
    textEditingController.text = _initialText + " @" + name + " ";
    textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: textEditingController.text.length));
    print(_initialText);
    update();
  }

  ///include the tag name to the text
  includeTag(String tag) async {
    tagsSuggestions = null;
    showSuggestions = false;
    textEditingController.text =
        textEditingController.text.split(" ").removeLast().toString() +
            " #" +
            tag +
            " ";
    update();
  }
}
