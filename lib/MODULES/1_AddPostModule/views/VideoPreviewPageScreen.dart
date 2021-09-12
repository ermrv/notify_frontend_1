import 'dart:io';
import 'dart:typed_data';

import 'package:MediaPlus/MODULES/1_AddPostModule/controllers/VideoPreviewPageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewPageScreen extends StatelessWidget {
  final File videoFile;
  final double aspectRatio;
  final Uint8List thumbData;

  VideoPreviewPageScreen(
      {Key key,
      @required this.videoFile,
      @required this.aspectRatio,
      @required this.thumbData})
      : super(key: key);

  final VideoPreviewPageController controller =
      Get.put(VideoPreviewPageController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoPreviewPageController>(
        initState: (state) {
          controller.videoFile = videoFile;
          controller.aspectRatio = aspectRatio;
          controller.thumbImage = thumbData;
          controller.initialise();
        },
        builder: (controller) => Scaffold(
              appBar: AppBar(
                title: Text("Preview"),
                actions: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        controller.sendBackData();
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 7.0),
                          child: Text(" Done ")),
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: controller.aspectRatio,
                          child: VideoPlayer(controller.videoPlayerController),
                        ),
                        controller.videoIsPlaying
                            ? Container()
                            : AspectRatio(
                                aspectRatio: controller.aspectRatio,
                                child: Image.memory(
                                  controller.thumbImage,
                                  fit: BoxFit.fill,
                                )),
                        AspectRatio(
                            aspectRatio: controller.aspectRatio,
                            child: GestureDetector(
                              onTap: () {
                                controller.playPauseController();
                              },
                              child: Center(
                                child: Container(
                                    height: 50.0,
                                    width: 50.0,
                                    child: controller.videoIsPlaying
                                        ? Container(
                                            height: 40.0,
                                            width: 40.0,
                                          )
                                        : Icon(
                                            Icons.play_arrow,
                                            size: 32.0,
                                            color: Colors.black,
                                          )),
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}
