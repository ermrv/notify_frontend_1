import 'dart:io';

import 'package:MediaPlus/MODULES/9_UserStatusManagerModule/views/AddStatusRelatedViews/AddStatusTextPageScreen.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class AddStatusPageController extends GetxController {
  //selected files
  List<File> selectedImagesFiles = [];
  List<File> selectedVideoFiles = [];

  // //selected files id
  // List selectedImagesId = [];
  // List selectedVideosId = [];

  List compressedImageFiles = [];
  List compressedVideoFiles = [];

  //selected images file will be stored here
  List selectedassetEntity = [].obs;
  var filesSelectedCount = 0.obs;

  ///this section will be used for storing the albums and the images data present
  ///in the corresponding album
  List<AssetPathEntity> albums = [];
  List<AssetEntity> assets = [];

  String value;

  @override
  onInit() {
    _getAlbums();
    super.onInit();
  }

  _getAlbums() async {
    var result = await PhotoManager.requestPermission();
    if (result) {
      await PhotoManager.getAssetPathList(
        type: RequestType.common,
      ).then((value) {
        this.albums = value;
        update();
        getAssets(0, this.albums[0].assetCount, this.albums[0].name);
        return value;
      });
    }
  }

  getAssets(int index, int length, String name) async {
    List<AssetEntity> media =
        await albums[index].getAssetListRange(start: 0, end: length);
    assets = media;
    value = name;
    update();
  }

  handleLongPress(AssetEntity element) async {
    if (selectedassetEntity.contains(element)) {
      int index = selectedassetEntity.indexOf(element);
      selectedassetEntity.remove(element);

      filesSelectedCount -= 1;
      print(filesSelectedCount);
    } else {
      selectedassetEntity.add(element);
      filesSelectedCount += 1;
      print(filesSelectedCount);
      print(selectedassetEntity);
    }
  }

  handleOnTap(AssetEntity element) async {
    handleLongPress(element);
  }

  // //navigator to the next route
  submitHandler() async {
    if (selectedassetEntity.length == 0)
      print("please select a file");
    else if (selectedassetEntity.length != 0) {
      await _getFiles();
      Get.off(() => AddStatusTextPageScreen(
            imageFiles: selectedImagesFiles,
            videoFiles: selectedVideoFiles,
          ));
    }
  }

  _getFiles() async {
    for (AssetEntity i in selectedassetEntity) {
      if (i.type == AssetType.image) {
        selectedImagesFiles.add(await i.file);
      } else if (i.type == AssetType.video) {
        selectedVideoFiles.add(await i.file);
      }
    }
  }
}
