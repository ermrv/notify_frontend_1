import 'dart:io';
import 'package:MediaPlus/MODULES/UserStatusManagerModule/views/StatusUploaderScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

List<File> selectedVideosFile = [];
List selectedVideosId = [];

class StatusVideoGridView extends StatefulWidget {
  @override
  _StatusVideoGridViewState createState() => _StatusVideoGridViewState();
}

class _StatusVideoGridViewState extends State<StatusVideoGridView> {
  List<AssetEntity> videoAssets = [];

  @override
  void initState() {
    _getAssets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return videoAssets.length == 0
        ? Container(
            child: Center(
              child: SpinKitThreeBounce(
                color: Colors.blue,
              ),
            ),
          )
        : Scaffold(
            body: GridView.builder(
              addAutomaticKeepAlives: true,
              itemCount: videoAssets.length,
              itemBuilder: (context, index) {
                return _GridImageElement(
                  element: videoAssets[index],
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
            ),
          );
  }

  _getAssets() async {
    var result = await PhotoManager.requestPermission();
    if (result) {
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        type: RequestType.video,
      );
      List<AssetEntity> videos =
          await albums[0].getAssetListRange(start: 0, end: 50);
      if (this.mounted) {
        setState(() {
          videoAssets = videos;
        });
      }
    } else {
      print("error");
    }
  }
}

class _GridImageElement extends StatefulWidget {
  final AssetEntity element;

  const _GridImageElement({Key key, @required this.element}) : super(key: key);
  @override
  __GridImageElementState createState() => __GridImageElementState();
}

class __GridImageElementState extends State<_GridImageElement>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: widget.element.thumbDataWithSize(200, 200),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done)
          return Container(
            child: GestureDetector(
              onTap: () async {
                File file = await widget.element.file;

                Get.to(() =>
                    StatusUploaderScreen(files: [file], contentType: "video"));
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
                        child:
                            Text(widget.element.duration.toString() + " Sec"),
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
