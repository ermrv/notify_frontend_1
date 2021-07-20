import 'package:MediaPlus/MODULES/1_AddPostModule/controllers/VideoGridDisplayController.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/KeepWidgetAliveModule/KeepWidgetAliveWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class VideosGridDisplay extends StatelessWidget {
  final VideoGridDisplayController videoGridDisplayController =
      Get.put(VideoGridDisplayController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoGridDisplayController>(
      builder: (controller) => controller.videoAssets.length == 0
          ? Container(
              child: Center(
                child: SpinKitThreeBounce(
                  size: 30.0,
                  color: Colors.blue,
                ),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: controller.albums.length == 0
                    ? Container()
                    : DropdownButton(
                        hint: Text(controller.value.toString()),
                        items: controller.albums
                            .map(
                              (e) => DropdownMenuItem(
                                  onTap: () {
                                    int index = controller.albums.indexOf(e);
                                    controller.getAssets(
                                        index, e.assetCount, e.name);
                                  },
                                  value: e.name,
                                  child: Container(
                                    child: Text(e.name.toString()),
                                  )),
                            )
                            .toList(),
                        onChanged: (value) {},
                      ),
              ),
              body: GridView.builder(
                addAutomaticKeepAlives: true,
                itemCount: controller.videoAssets.length,
                itemBuilder: (context, index) {
                  return KeepWidgetAliveWrapper(
                    child: _GridImageElement(
                      element: controller.videoAssets[index],
                      controller: controller,
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
              ),
            ),
    );
  }

//   _getAlbums() async {
//     var result = await PhotoManager.requestPermission();
//     if (result) {
//       List<AssetPathEntity> albumsList = await PhotoManager.getAssetPathList(
//         type: RequestType.video,
//       ).then((value) {
//         this.albums = value;
//         if (this.mounted) {
//           setState(() {});
//         }
//         getAssets(0, this.albums[0].assetCount, this.albums[0].name);
//         return value;
//       });
//     }
//   }

//   getAssets(int index, int length, String name) async {
//     List<AssetEntity> videos =
//         await albums[index].getAssetListRange(start: 0, end: length);
//     videoAssets =videos;
//     value = name;
//     if (this.mounted) {
//       setState(() {});
//     }
//   }
}

class _GridImageElement extends StatelessWidget {
  final AssetEntity element;
  final VideoGridDisplayController controller;
  const _GridImageElement({Key key, @required this.element, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: element.thumbDataWithSize(200, 200),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done)
          return Container(
            child: GestureDetector(
              onTap: () {
                controller.handleOnTap(element);
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.memory(
                    snapshot.data,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                      bottom: 5.0,
                      right: 5.0,
                      child: Container(
                        child: Text(element.duration.toString() + " Sec"),
                      ))
                ],
              ),
            ),
          );
        return Container();
      },
    );
  }
}
