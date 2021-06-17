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
                            ),
                          )),
                      Container(
                          width: screenWidth * 5,
                          child: AspectRatio(
                              aspectRatio: 0.8,
                              child: Container(
                                  alignment: Alignment.center,
                                  child: files.length > 3
                                      ? Text(
                                          (files.length - 3).toString() +
                                              " more",
                                        )
                                      : Container())))
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
