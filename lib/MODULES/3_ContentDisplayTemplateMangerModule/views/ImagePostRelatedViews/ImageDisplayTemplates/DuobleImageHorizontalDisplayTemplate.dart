import 'dart:io';

import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ImagePostRelatedViews/FullImagePostDisplayTemplate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoubleImageHorizontalDisplayTemplate extends StatelessWidget {
  final List images;

  const DoubleImageHorizontalDisplayTemplate({Key key, @required this.images})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      child: AspectRatio(
        aspectRatio: 0.9,
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
                      aspectRatio: 0.45,
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
                  width: screenWidth * 0.5,
                  child: AspectRatio(
                      aspectRatio: 0.45,
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
