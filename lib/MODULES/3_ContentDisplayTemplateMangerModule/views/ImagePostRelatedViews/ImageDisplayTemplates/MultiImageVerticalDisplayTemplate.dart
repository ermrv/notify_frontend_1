import 'dart:io';

import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ImagePostRelatedViews/FullImagePostDisplayTemplate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultiImageVerticalDisplayTemplate extends StatelessWidget {
  final List images;

  const MultiImageVerticalDisplayTemplate({Key key, @required this.images})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AspectRatio(
        aspectRatio: 0.8,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => FullScreenImagePostDisplay(
                      imagesData: images,
                      initialPage: 0,
                    ));
              },
              child: Container(
                width: screenWidth,
                child: AspectRatio(
                    aspectRatio: 1.6,
                    child: CachedNetworkImage(
                      imageUrl: ApiUrlsData.domain + images[0]["path"],
                      alignment: Alignment.topCenter,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            Container(
              width: screenWidth,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => FullScreenImagePostDisplay(
                            imagesData: images,
                            initialPage: 1,
                          ));
                    },
                    child: Container(
                        width: screenWidth * 0.5,
                        child: AspectRatio(
                            aspectRatio: 0.8,
                            child: CachedNetworkImage(
                              imageUrl: ApiUrlsData.domain + images[1]["path"],
                              alignment: Alignment.topCenter,
                              fit: BoxFit.cover,
                            ))),
                  ),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => FullScreenImagePostDisplay(
                                imagesData: images,
                                initialPage: 2,
                              ));
                        },
                        child: Container(
                            width: screenWidth * 0.5,
                            child: AspectRatio(
                                aspectRatio: 0.8,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      ApiUrlsData.domain + images[2]["path"],
                                  alignment: Alignment.topCenter,
                                  fit: BoxFit.cover,
                                ))),
                      ),
                      images.length > 3
                          ? Container(
                              width: screenWidth * 0.5,
                              child: AspectRatio(
                                  aspectRatio: 0.8,
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: images.length > 3
                                          ? SizedBox(
                                              width: 50.0,
                                              height: 50.0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Get.to(() =>
                                                      FullScreenImagePostDisplay(
                                                        imagesData: images,
                                                        initialPage: 4,
                                                      ));
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.all(5.0),
                                                  decoration: BoxDecoration(
                                                      color: Colors.black54,
                                                      shape: BoxShape.circle),
                                                  child: Text(
                                                    "+" +
                                                        (images.length - 3)
                                                            .toString() +
                                                        " ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 22.0,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container())))
                          : Container(),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
