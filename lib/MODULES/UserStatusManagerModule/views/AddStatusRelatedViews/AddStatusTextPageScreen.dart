import 'dart:io';

import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/UserStatusManagerModule/controllers/AddStatusRelatedControllers/AddStatusTextPageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class AddStatusTextPageScreen extends StatelessWidget {
  final List<File> imageFiles;
  final List<File> videoFiles;
  final addStatusTextPageController = Get.put(AddStatusTextPageController());

  AddStatusTextPageScreen({Key key, this.imageFiles, this.videoFiles})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddStatusTextPageController>(
      initState: (state) {
        addStatusTextPageController.imageFiles = imageFiles;
        addStatusTextPageController.videoFiles = videoFiles;
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
                  child:controller.isUploading?Text(" Posting "):Text(" Post "),
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
            ///for images files
            for (File i in controller.imageFiles)
              Container(
                child: Stack(
                  children: [
                    Container(
                      height: screenHeight,
                      width: screenWidth,
                      child: Image.file(
                        i,
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
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.5)),
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
              ),
            //for video files
            for (File i in controller.videoFiles)
              Container(
                child: Stack(
                  children: [
                    Container(
                        height: screenHeight,
                        width: screenWidth,
                        child: FutureBuilder(
                          future: controller.getVideoThumbnail(i),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Image.memory(snapshot.data);
                            }
                            return Container();
                          },
                        )),
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
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.5)),
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
              ),
          ],
        ),
      ),
    );
  }
}
