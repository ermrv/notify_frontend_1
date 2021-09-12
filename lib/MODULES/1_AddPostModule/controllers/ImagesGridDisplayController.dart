import 'dart:io';

import 'package:MediaPlus/MODULES/1_AddPostModule/views/SelectedImagesDisplayTemplates/ImageDisplayTemplateSelector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:photo_manager/photo_manager.dart';

class ImagesGridDisplayController extends GetxController {
  //selected images file will be stored here
  List selectedImageEntity = [].obs;
  var filesSelectedCount = 0.obs;

  ///this section will be used for storing the albums and the images data present
  ///in the corresponding album
  List<AssetPathEntity> albums = [];
  List<AssetEntity> imageAssets = [];
  List<double> filesAspectRatio = [];

  String value;

  @override
  void onInit() {
    _getAlbums();
    super.onInit();
  }

  _getAlbums() async {
    var result = await PhotoManager.requestPermission();
    if (result) {
      await PhotoManager.getAssetPathList(
        type: RequestType.image,
      ).then((value) {
        this.albums = value;
        update();
        getAssets(0, this.albums[0].assetCount, this.albums[0].name);
        return value;
      });
    }
  }

  getAssets(int index, int length, String name) async {
    List<AssetEntity> photos =
        await albums[index].getAssetListRange(start: 0, end: length);
    imageAssets = photos;
    value = name;
    update();
  }

  handleLongPress(AssetEntity element) async {
    if (selectedImageEntity.contains(element)) {
      int index = selectedImageEntity.indexOf(element);
      selectedImageEntity.remove(element);
      filesAspectRatio.removeAt(index);

      filesSelectedCount -= 1;
      print(filesSelectedCount);
    } else {
      selectedImageEntity.add(element);
      double aspectRatio = element.width / element.height;
      filesAspectRatio.add(aspectRatio);
      filesSelectedCount += 1;
      print(filesSelectedCount);
      print(selectedImageEntity);
    }
  }

  handleOnTap(AssetEntity element) async {
    handleLongPress(element);
  }

  //navigator to the next route
  submitHandler() async {
    if (selectedImageEntity.length == 0)
      print("please select a file");

    ///if only one image is selected get back from here
    else if (selectedImageEntity.length == 1) {
      await _getFiles().then((value) => Get.back(result: {
            "files": value,
            "templateType": "singleImage",
            "aspectRatio": filesAspectRatio[0]
          }));
    }

    ///if more than one image is selected get to the page to select layout
    else {
      // await _getFiles().then((value) async {
      //   await Get.to(() =>
      //           ImageDisplayTemplateSelector(files: value,aspectRatio:filesAspectRatio,))
      //       .then((value) => Get.back(result: value));
      // });
      List<File> _temp = await _getFiles();
      Map<String, dynamic> result = await Get.to(() =>
          ImageDisplayTemplateSelector(
              files: _temp, aspectRatio: filesAspectRatio));
      Get.back(result: result);
    }
  }

  Future<List<File>> _getFiles() async {
    List<File> _selectedFiles = [];
    for (var i = 0; i <= selectedImageEntity.length - 1; i++) {
      _selectedFiles.add(await selectedImageEntity[i].file);
    }
    return _selectedFiles;
  }
}
