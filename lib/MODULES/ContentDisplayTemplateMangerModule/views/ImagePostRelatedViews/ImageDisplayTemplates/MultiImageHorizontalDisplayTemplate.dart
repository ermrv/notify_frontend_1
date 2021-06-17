import 'dart:io';

import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/ContentDisplayTemplateMangerModule/views/ImagePostRelatedViews/FullImagePostDisplayTemplate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultiImageHorizontalDisplayTemplate extends StatelessWidget {
  final List images;

  const MultiImageHorizontalDisplayTemplate({Key key, @required this.images})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AspectRatio(
        aspectRatio: 0.8,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => FullScreenImagePostDisplay(
                      imagesData: images,
                      initialPage: 0,
                    ));
              },
              child: Container(
                width: screenWidth * 0.5,
                child: AspectRatio(
                    aspectRatio: 0.4,
                    child: CachedNetworkImage(
                      imageUrl: ApiUrlsData.domain + images[0]["path"],
                      alignment: Alignment.topCenter,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            Container(
              width: screenWidth * 0.5,
              child: Column(
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
                          ),
                        )),
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
                                      height: 20.0,
                                      width: 20.0,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                          color: Colors.black54,
                                          shape: BoxShape.circle),
                                      child: images.length > 3
                                          ? Text(
                                              "+" +
                                                  (images.length - 3)
                                                      .toString() +
                                                  " ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
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
