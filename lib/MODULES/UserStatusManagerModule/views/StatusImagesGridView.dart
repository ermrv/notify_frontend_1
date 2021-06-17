import 'package:MediaPlus/MODULES/UserStatusManagerModule/views/StatusUploaderScreen.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

List<File> selectedImagesFile = [];
List selectedImagesId = [];

class StatusImagesGridView extends StatefulWidget {
  @override
  _StatusImagesGridViewState createState() => _StatusImagesGridViewState();
}

class _StatusImagesGridViewState extends State<StatusImagesGridView>
    with SingleTickerProviderStateMixin {
  List<AssetPathEntity> albums = [];
  List<AssetEntity> imageAssets = [];
  AnimationController _animationController;
  String value;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _getAlbums();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return imageAssets.length == 0
        ? Container(
            child: Center(
              child: SpinKitThreeBounce(
                color: Colors.blue,
              ),
            ),
          )
        : Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndDocked,
            floatingActionButton: Container(
              margin: EdgeInsets.all(5.0),
              height: 45.0,
              width: 45.0,
              decoration:
                  BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
              child: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (selectedImagesFile.length == 0) {
                    print("please select a file");
                  } else {
                    List<File> selectedFiles = selectedImagesFile;
                    selectedImagesFile = [];
                    Get.to(() => StatusUploaderScreen(
                        files: selectedFiles, contentType: "image"));
                  }
                },
              ),
            ),
            body: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 60.0),
                  child: GridView.builder(
                    itemCount: imageAssets.length,
                    itemBuilder: (context, index) {
                      return _GridImageElement(
                        element: imageAssets[index],
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  height: 40.0,
                  child: albums.length == 0
                      ? Container()
                      : DropdownButton(
                          hint: Text(value.toString()),
                          items: albums
                              .map(
                                (e) => DropdownMenuItem(
                                    onTap: () {
                                      int index = albums.indexOf(e);
                                      getAssets(index, e.assetCount, e.name);
                                    },
                                    value: e.name,
                                    child: Container(
                                      child: Text(e.name.toString()),
                                    )),
                              )
                              .toList(),
                          onChanged: (value) {},
                        ),
                )
              ],
            ));
  }

  _getAlbums() async {
    var result = await PhotoManager.requestPermission();
    if (result) {
      List<AssetPathEntity> albumsList = await PhotoManager.getAssetPathList(
        type: RequestType.image,
      ).then((value) {
        this.albums = value;
        if (this.mounted) {
          setState(() {});
        }
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
    if (this.mounted) {
      setState(() {});
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
              onLongPress: () async {
                if (selectedImagesId.contains(widget.element.id)) {
                  selectedImagesFile.remove(widget.element.file);
                  selectedImagesId.remove(widget.element.id);
                  setState(() {});
                } else {
                  File file = await widget.element.file;
                  selectedImagesFile.add(file);
                  selectedImagesId.add(widget.element.id);
                  setState(() {});
                }
              },
              onTap: () async {
                if (selectedImagesId.length == 0) {
                  File file = await widget.element.file;
                  Get.to(() => StatusUploaderScreen(
                      files:[file], contentType: "image"));
                } else if (selectedImagesId.length != 0) {
                  if (selectedImagesId.contains(widget.element.id)) {
                    selectedImagesFile.remove(widget.element.file);
                    selectedImagesId.remove(widget.element.id);
                    setState(() {});
                  } else {
                    File file = await widget.element.file;
                    selectedImagesFile.add(file);
                    selectedImagesId.add(widget.element.id);
                    setState(() {});
                  }
                }
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.memory(
                    snapshot.data,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                      right: 5.0,
                      top: 5.0,
                      child: selectedImagesId.contains(widget.element.id)
                          ? Container(
                              height: 20.0,
                              width: 20.0,
                              decoration: BoxDecoration(
                                  color: Colors.blue, shape: BoxShape.circle),
                              child: Center(
                                child: Icon(
                                  Icons.done,
                                  color: Colors.white,
                                  size: 14.0,
                                ),
                              ),
                            )
                          : Container())
                ],
              ),
            ),
          );
        return Container();
      },
    );
  }
}
