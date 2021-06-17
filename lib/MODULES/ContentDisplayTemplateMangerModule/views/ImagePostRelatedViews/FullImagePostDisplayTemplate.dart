import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';

class FullScreenImagePostDisplay extends StatefulWidget {
  final List imagesData;
  final int initialPage;

  const FullScreenImagePostDisplay({Key key, this.imagesData, this.initialPage})
      : super(key: key);

  @override
  _FullScreenImagePostDisplayState createState() =>
      _FullScreenImagePostDisplayState();
}

class _FullScreenImagePostDisplayState
    extends State<FullScreenImagePostDisplay> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Get.back();
      },
      child: Card(
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          color: Colors.transparent,
          width: screenWidth,
          child: CarouselSlider(
            items: widget.imagesData.map((e) {
              return CachedNetworkImage(
                alignment: Alignment.center,
                imageUrl: ApiUrlsData.domain + e["path"],
                fit: BoxFit.fitWidth,
                progressIndicatorBuilder: (context, url, progress) {
                  return Stack(
                    children: [
                      Center(
                        child: Container(
                            width: 60.0,
                            child: LinearProgressIndicator(
                              value: progress.progress,
                              backgroundColor: Theme.of(context).accentColor,
                            )),
                      )
                    ],
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              initialPage: widget.initialPage,
              aspectRatio: screenWidth / screenHeight,
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
    );
  }
}
