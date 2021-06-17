import 'dart:io';
import 'dart:typed_data';

import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/AddPostModule/MediaCompressorModule/ImageCompressor.dart';
import 'package:MediaPlus/MODULES/AddPostModule/MediaCompressorModule/VideoCompressor.dart';
import 'package:MediaPlus/MODULES/AddPostModule/views/AddPostScreenBottomSheet.dart';
import 'package:MediaPlus/MODULES/AddPostModule/views/SelectedImagesDisplayTemplates/DuobleImageHorizontalDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/AddPostModule/views/SelectedImagesDisplayTemplates/DuobleImageVerticalDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/AddPostModule/views/SelectedImagesDisplayTemplates/ImageCarouselDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/AddPostModule/views/ImagesGridDisplay.dart';
import 'package:MediaPlus/MODULES/AddPostModule/views/SelectedImagesDisplayTemplates/MultiImageHorizontalDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/AddPostModule/views/SelectedImagesDisplayTemplates/MultiImageVerticalDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/AddPostModule/views/SelectedImagesDisplayTemplates/SingleImageDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/AddPostModule/views/VideoGridDisplay.dart';
import 'package:MediaPlus/MODULES/UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/MODULES/UserProfileModule/views/UserProfileScreen.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart' as dio;

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

  //compressed images and videos in Uint8Lst
  //ready to be uploaded
  List<Uint8List> compressedImages;
  Uint8List compressedVideo;
  Uint8List compressedThumbnail;

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

  ///get images
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
    } else if(videoFile == null &&
        imageFiles == null &&
        textEditingController.text == null){
      isUploading = false;
    }

    update();
  }

  //to upload the text post
  uploadTextPost() async {
    var response = await ApiServices.postWithAuth(ApiUrlsData.addTextPost,
        {"description": textEditingController.text}, userToken);
    print(response);
    if (response != "error") {
      isUploading = false;
      Get.snackbar("Uploaded", "Task Completed");
      update();
      // Get.to(() => UserProfileScreen());
    }else{
       isUploading = false;
      Get.snackbar("Error", "Error occured");
      update();
    }
  }

  ///to upload the compressed images
  uploadImages() async {
    // var headers = <String, String>{
    //   "authorization": "Bearer " + userToken,
    //   "Content-type": "multipart/form-data"
    // };
    // var formData = dio.FormData.fromMap({
    //   "description": textEditingController.text,
    //   "templateType": templateType,
    //   "postFile": [
    //     await dio.MultipartFile.fromFile(imageFiles[0].path,
    //         contentType: MediaType("image", "jpg")),
    //   ]
    // });

    // var response = await Dio().post(ApiUrlsData.addImagePost,
    //     data: formData, options: Options(headers: headers));

    // print(response.statusCode);

    // //create the request object
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(ApiUrlsData.addImagePost),
    );

    //adding the headers
    request.headers["authorization"] = "Bearer " + userToken;
    request.headers["Content-type"] = "multipart/form-data";

    //adding body contents
    // request.fields["aspectRatio"] = aspectRatio.toString();
    request.fields["description"] = textEditingController.text;
    request.fields["templateType"] = templateType;
    request.fields["postType"] = "images";
    // request.fields["location"] = location;

    //adding files
    //
    for (Uint8List i in compressedImages) {
      int index = compressedImages.indexOf(i);
      print(index);
      request.files.add(http.MultipartFile.fromBytes("postFile", i.toList(),
          filename: imageFiles[index].path,
          contentType: MediaType(
              "image", imageFiles[index].path.split(".").last.toString())));
    }
    var response = await request.send();
    response.stream.listen((data) => print(data));
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

  ///video uploader
  uploadVideo() async {
    //create the request object
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(ApiUrlsData.addVideoPost),
    );

    //adding the headers
    request.headers["authorization"] = "Bearer " + userToken;
    request.headers["Content-type"] = "multipart/form-data";

    //adding body contents
    request.fields["aspectRatio"] = aspectRatio.toString();
    if (textEditingController.text != null) {
      request.fields["description"] = textEditingController.text;
    }

    request.fields["postType"] = "video";
    // request.fields["location"] = location;

    //adding thumbnail file
    request.files.add(http.MultipartFile.fromBytes("postFile", compressedVideo,
        filename: videoFile.path,
        contentType:
            MediaType("video", videoFile.path.split(".").last.toString())));

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      isUploading = false;
      Get.snackbar("Uploaded", "Task Completed");
      update();
    }else{
      isUploading = false;
      Get.snackbar("Error", "Error Occured");
      update();
    }
    response.stream.listen((value) {
      print(value.length);
    });
  }
}
