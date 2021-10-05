import 'dart:io';

import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:flutter/material.dart';

class MultiImageHorizontalDisplayTemplate extends StatelessWidget {
  final List<File> files;

  const MultiImageHorizontalDisplayTemplate({Key key, @required this.files})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AspectRatio(
        aspectRatio: 0.8,
        child: Row(
          children: [
            Container(
              width: screenWidth * 0.5,
              child: AspectRatio(
                aspectRatio: 0.4,
                child: Image.file(
                  files[0],
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            Container(
              width: screenWidth * 0.5,
              child: Column(
                children: [
                  Container(
                      width: screenWidth * 0.5,
                      child: AspectRatio(
                        aspectRatio: 0.8,
                        child: Image.file(
                          files[1],
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                      )),
                  Stack(
                    children: [
                      Container(
                          width: screenWidth * 0.5,
                          child: AspectRatio(
                            aspectRatio: 0.8,
                            child: Image.file(
                              files[2],
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                          )),
                      files.length > 3
                          ? Container(
                              width: screenWidth * 0.5,
                              child: AspectRatio(
                                  aspectRatio: 0.8,
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: files.length > 3
                                          ? SizedBox(
                                              width: 50.0,
                                              height: 50.0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  // Get.to(() =>
                                                  //     FullScreenImagePostDisplay(
                                                  //       imagesData: images,
                                                  //       initialPage: 4,
                                                  //     ));
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.all(5.0),
                                                  decoration: BoxDecoration(
                                                      color: Colors.black54,
                                                      shape: BoxShape.circle),
                                                  child: Text(
                                                    "+" +
                                                        (files.length - 3)
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
