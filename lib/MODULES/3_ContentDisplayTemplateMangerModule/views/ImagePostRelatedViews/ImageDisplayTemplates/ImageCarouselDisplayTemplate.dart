import 'dart:io';

import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ImagePostRelatedViews/FullImagePostDisplayTemplate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageCarouselDisplayTemplate extends StatefulWidget {
  final List images;
  final double aspectRatio;

  const ImageCarouselDisplayTemplate({Key key, this.images, this.aspectRatio})
      : super(key: key);

  @override
  _ImageCarouselDisplayTemplateState createState() =>
      _ImageCarouselDisplayTemplateState();
}

class _ImageCarouselDisplayTemplateState
    extends State<ImageCarouselDisplayTemplate> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => FullScreenImagePostDisplay(
              imagesData: widget.images,
              initialPage: currentIndex,
            ));
      },
      child: Container(
        child: AspectRatio(
          aspectRatio: widget.aspectRatio == null || widget.aspectRatio < 0.8
              ? 0.9
              : widget.aspectRatio,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                width: screenWidth,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CarouselSlider(
                    items: widget.images.map((e) {
                      return AspectRatio(
                        aspectRatio: widget.aspectRatio == null ||
                                widget.aspectRatio < 0.8
                            ? 0.9
                            : widget.aspectRatio,
                        child: CachedNetworkImage(
                          imageUrl: ApiUrlsData.domain + e["path"],
                          alignment: Alignment.topCenter,
                          fit: BoxFit.cover,
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      aspectRatio: widget.aspectRatio == null
                          ? 0.9
                          : widget.aspectRatio < 0.8
                              ? 0.8
                              : widget.aspectRatio > 0.5
                                  ? 0.5
                                  : widget.aspectRatio,
                      enableInfiniteScroll: false,
                      viewportFraction: 1.0,
                      autoPlay: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 8.0,
                  child: Container(
                    width: screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (var i = 0; i < widget.images.length; i++)
                          Container(
                            margin: EdgeInsets.only(left: 3.0, right: 3.0),
                            width: 6.0,
                            height: 6.0,
                            decoration: BoxDecoration(
                                color: currentIndex == i
                                    ? Colors.blue
                                    : Colors.grey[100],
                                borderRadius: BorderRadius.circular(5.0)),
                          )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
