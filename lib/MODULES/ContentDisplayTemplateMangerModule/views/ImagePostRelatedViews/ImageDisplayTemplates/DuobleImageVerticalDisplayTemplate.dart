import 'dart:io';

import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/ContentDisplayTemplateMangerModule/views/ImagePostRelatedViews/FullImagePostDisplayTemplate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoubleImageVerticalDisplayTemplate extends StatelessWidget {
  final List images;

  const DoubleImageVerticalDisplayTemplate({Key key, @required this.images})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      child: AspectRatio(
        aspectRatio: 0.9,
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
                  decoration: BoxDecoration(border: Border.all(width: 1.0)),
                  width: screenWidth,
                  child: AspectRatio(
                      aspectRatio: 1.81,
                      child: CachedNetworkImage(
                        imageUrl: ApiUrlsData.domain + images[0]["path"],
                        alignment: Alignment.topCenter,
                        fit: BoxFit.cover,
                      ))),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => FullScreenImagePostDisplay(
                      imagesData: images,
                      initialPage: 1,
                    ));
              },
              child: Container(
                  decoration: BoxDecoration(border: Border.all(width: 1.0)),
                  width: screenWidth,
                  child: AspectRatio(
                      aspectRatio: 1.81,
                      child: CachedNetworkImage(
                        imageUrl: ApiUrlsData.domain + images[1]["path"],
                        alignment: Alignment.topCenter,
                        fit: BoxFit.cover,
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
