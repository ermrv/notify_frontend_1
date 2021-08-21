import 'dart:typed_data';

import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/controllers/AddPostPageController.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/AddPostScreenBottomSheet.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/CreateEventPageScreen.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/CreatePollPageScreen.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/SelectedImagesDisplayTemplates/DuobleImageHorizontalDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/SelectedImagesDisplayTemplates/DuobleImageVerticalDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/4_ContestingModule/ContestHostingModule/views/CreateContestScreen.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPostPageScreen extends StatelessWidget {
  final controller = Get.put(AddPostPageController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPostPageController>(
      builder: (controller) => Scaffold(
        bottomNavigationBar: controller.showBottomNavbar
            ? Container(
                decoration: BoxDecoration(border: Border(top: BorderSide())),
                child: Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.image),
                        onPressed: () {
                          controller.getImageFiles();
                        }),
                    IconButton(
                        icon: Icon(Icons.ondemand_video),
                        onPressed: () {
                          controller.getVideoFile();
                        }),
                    IconButton(
                        icon: Icon(Icons.event),
                        onPressed: () {
                          Get.to(() => CreateEventPageScreen());
                        }),
                    IconButton(
                        icon: Icon(Icons.poll),
                        onPressed: () {
                          Get.to(() => CreatePollPageScreen());
                        }),
                    // IconButton(
                    //     icon: Icon(Icons.emoji_events),
                    //     onPressed: () {
                    //       Get.to(() => CreateContestScreen());
                    //     }),
                    IconButton(
                        icon: Icon(Icons.more_horiz),
                        onPressed: () {
                          controller.showBottomSheet();
                        }),
                  ],
                ),
              )
            : Container(
                height: 0.0,
              ),
        appBar: AppBar(
          title: Text("Share a post"),
          actions: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  if (!controller.isUploading) {
                    controller.uploadData();
                  }
                },
                child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 7.0),
                    child: controller.isUploading
                        ? Text("Uploading")
                        : Text(" Post ")),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: CachedNetworkImage(
                            imageUrl:
                                PrimaryUserData.primaryUserData.profilePic,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                PrimaryUserData.primaryUserData.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 16.0,
                                  ),
                                  Text(" "),
                                  Container(
                                    child: controller.location == null
                                        ? Text("Select Location")
                                        : Text(controller.location.toString()),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                  width: screenWidth,
                  child: TextFormField(
                    controller: controller.textEditingController,
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(fontSize: 16.0),
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        hintText: "Just ,share it!",
                        hintStyle: TextStyle(fontSize: 16.0)),
                  ),
                ),
                Container(
                  height: 15.0,
                ),
                controller.imageFiles == null
                    ? Container()
                    : Stack(
                        children: [
                          controller.getTemplate(controller.templateType),
                          Positioned(
                              top: 5.0,
                              right: 5.0,
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.8)),
                                child: IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      controller.removeFiles();
                                    }),
                              ))
                        ],
                      ),
                controller.videoFile == null
                    ? Container()
                    : Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: controller.aspectRatio,
                            child: Image.memory(
                              controller.videoThumbImage,
                              fit: BoxFit.fill,
                            ),
                          ),
                          AspectRatio(
                            aspectRatio: controller.aspectRatio,
                            child: Center(
                              child: Container(
                                height: 60.0,
                                width: 60.0,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 5.0),
                                  shape: BoxShape.circle,
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.2),
                                ),
                                child: Icon(
                                  Icons.play_arrow,
                                  color: Theme.of(context).primaryColor,
                                  size: 32.0,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              top: 5.0,
                              right: 5.0,
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.8)),
                                child: IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      controller.removeFiles();
                                    }),
                              ))
                        ],
                      ),
                controller.compressedImages == null
                    ? Container()
                    : Column(
                        children: [
                          for (Uint8List i in controller.compressedImages)
                            Image.memory(i)
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
