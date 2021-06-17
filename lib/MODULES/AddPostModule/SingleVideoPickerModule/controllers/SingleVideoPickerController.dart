import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:photo_manager/photo_manager.dart';

class SingleVideoPickerControler extends GetxController {
  List<AssetPathEntity> albums = [];
  List<AssetEntity> videoAssets = [];
  String value;

  @override
  void onInit() {
    _getAlbums();
    super.onInit();
  }

  _getAlbums() async {
    var result = await PhotoManager.requestPermission();
    if (result) {
      List<AssetPathEntity> albumsList = await PhotoManager.getAssetPathList(
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
    print(videoAssets);
    value = name;
    update();
  }
}
