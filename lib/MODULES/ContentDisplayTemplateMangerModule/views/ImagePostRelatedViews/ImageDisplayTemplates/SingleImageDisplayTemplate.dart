import 'dart:io';

import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/ContentDisplayTemplateMangerModule/views/ImagePostRelatedViews/FullImagePostDisplayTemplate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleImageDisplayTemplate extends StatelessWidget {
  final imageData;
  final double aspectRatio;

  const SingleImageDisplayTemplate(
      {Key key, @required this.imageData, @required this.aspectRatio})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => FullScreenImagePostDisplay(
              imagesData: [imageData],
              initialPage: 0,
            ));
      },
      child: Container(
        width: screenWidth,
        height: screenWidth * 0.8,
        child: CachedNetworkImage(
          imageUrl: ApiUrlsData.domain + imageData["path"],
          alignment: Alignment.topCenter,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
