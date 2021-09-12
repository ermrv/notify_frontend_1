import 'dart:io';
import 'dart:typed_data';

import 'package:MediaPlus/MODULES/1_AddPostModule/views/VideoPreviewPageScreen.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:photo_manager/photo_manager.dart';

class VideoGridDisplayController extends GetxController {
  //selected videos file will be stored here
  // List selectedvideoEntity = [].obs;
  // var filesSelectedCount = 0.obs;

  ///this section will be used for storing the albums and the videos data present
  ///in the corresponding album
  List<AssetPathEntity> albums = [];
  List<AssetEntity> videoAssets = [];
  double aspectRatio;

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
        type: RequestType.video,
      ).then((value) {
        this.albums = value;
        update();
        getAssets(0, this.albums[0].assetCount, this.albums[0].name);
        return value;
      });
    }
  }

  getAssets(int index, int length, String name) async {
    List<AssetEntity> videos =
        await albums[index].getAssetListRange(start: 0, end: length);
    videoAssets = videos;
    value = name;
    update();
  }

  handleOnTap(AssetEntity element) async {
    File file = await element.file;
    aspectRatio = element.width / element.height;
    Uint8List thumbData =
        await element.thumbDataWithSize(element.width, element.height);
    Map<String, dynamic> videoFileData =
        await Get.to(() => VideoPreviewPageScreen(
              videoFile: file,
              aspectRatio: aspectRatio,
              thumbData: thumbData,
            ));
    Get.back(result: videoFileData);
  }
}
