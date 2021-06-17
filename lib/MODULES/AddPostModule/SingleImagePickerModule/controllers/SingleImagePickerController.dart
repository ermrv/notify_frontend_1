import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:photo_manager/photo_manager.dart';

class SingleImagePickerControler extends GetxController {
  List<AssetPathEntity> albums = [];
  List<AssetEntity> imageAssets = [];
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
    print(imageAssets);
    value = name;
    update();
  }
}
