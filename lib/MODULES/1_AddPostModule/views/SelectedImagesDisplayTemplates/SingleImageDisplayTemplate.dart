import 'dart:io';

import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:flutter/material.dart';

class SingleImageDisplayTemplate extends StatelessWidget {
  final File imageFile;
  final double aspectRatio;

  const SingleImageDisplayTemplate(
      {Key key, @required this.imageFile, @required this.aspectRatio})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          width: screenWidth,
          child: Image.file(
            imageFile,
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          )),
    );
  }
}
