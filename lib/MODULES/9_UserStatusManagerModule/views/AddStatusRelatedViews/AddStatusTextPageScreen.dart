import 'dart:io';

import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/9_UserStatusManagerModule/controllers/AddStatusRelatedControllers/AddStatusTextPageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class AddStatusTextPageScreen extends StatelessWidget {
  final List selectedEntities;
  final addStatusTextPageController = Get.put(AddStatusTextPageController());

  AddStatusTextPageScreen({
    Key key,
    @required this.selectedEntities,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddStatusTextPageController>(
      initState: (state) {
        addStatusTextPageController.assetEntity = selectedEntities;
      },
      builder: (controller) => Scaffold(
        appBar: AppBar(
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10.0),
              height: 30.0,
              alignment: Alignment.center,
              child: TextButton(
                child: Container(
                  height: 21.0,
                  alignment: Alignment.center,
                  child: controller.isUploading
                      ? Text(" Posting ")
                      : Text(" Post "),
                ),
                onPressed: () {
                  if (!controller.isUploading) {
                    controller.postHandler();
                  }
                },
              ),
            ),
          ],
        ),
        body: PageView(
          scrollDirection: Axis.horizontal,
          children: [
            
          ],
        ),
      ),
    );
  }
}

_getTemplate(AssetEntity assetEntity) async {

  if (assetEntity.type == AssetType.image) {
    File imageFile = await assetEntity.file;
    return ImageStatusTextTemplate(imageFile: imageFile);
  } else if (assetEntity.type == AssetType.video) {
    File videoFile = await assetEntity.file;
    return VideoStatusTextTepmlate(videoFile: videoFile);
  }
}

///image files status

class ImageStatusTextTemplate extends StatelessWidget {
  final File imageFile;

  const ImageStatusTextTemplate({Key key, @required this.imageFile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            height: screenHeight,
            width: screenWidth,
            child: Image.file(
              imageFile,
              alignment: Alignment.center,
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              decoration: BoxDecoration(
                  color: Colors.black26,
                  border: Border.all(
                      color: Theme.of(context).accentColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(10.0)),
              width: screenWidth,
              child: TextFormField(
                maxLines: null,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "write a caption.."),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class VideoStatusTextTepmlate extends StatefulWidget {
  final File videoFile;

  const VideoStatusTextTepmlate({Key key, @required this.videoFile})
      : super(key: key);

  @override
  State<VideoStatusTextTepmlate> createState() =>
      _VideoStatusTextTepmlateState();
}

class _VideoStatusTextTepmlateState extends State<VideoStatusTextTepmlate> {
  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.file(widget.videoFile);
    _videoPlayerController.initialize();
    _videoPlayerController.play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
              height: screenHeight,
              width: screenWidth,
              child: VideoPlayer(_videoPlayerController)),
          Positioned(
            child: Center(
              child: Container(
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      color: Colors.black26, shape: BoxShape.circle),
                  child: Icon(
                    Icons.play_arrow,
                    size: 32.0,
                  )),
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              decoration: BoxDecoration(
                  color: Colors.black26,
                  border: Border.all(
                      color: Theme.of(context).accentColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(10.0)),
              width: screenWidth,
              child: TextFormField(
                maxLines: null,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "write a caption.."),
              ),
            ),
          )
        ],
      ),
    );
  }
}
