import 'dart:io';

import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:flutter/material.dart';

class DoubleImageHorizontalDisplayTemplate extends StatelessWidget {
  final List<File> files;

  const DoubleImageHorizontalDisplayTemplate({Key key,@required this.files})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      child: AspectRatio(
        aspectRatio: 0.9,
        child: Row(
          children: [
            Container(
                decoration: BoxDecoration(border: Border.all(width: 1.0)),
                width: screenWidth * 0.5,
                child: AspectRatio(
                    aspectRatio: 0.45,
                    child: Image.file(
                      files[0],
                      fit: BoxFit.cover,
                    ))),
            Container(
                decoration: BoxDecoration(border: Border.all(width: 1.0)),
                width: screenWidth * 0.5,
                child: AspectRatio(
                    aspectRatio: 0.45,
                    child: Image.file(
                      files[1],
                      fit: BoxFit.cover,
                    )))
          ],
        ),
      ),
    );
  }
}
