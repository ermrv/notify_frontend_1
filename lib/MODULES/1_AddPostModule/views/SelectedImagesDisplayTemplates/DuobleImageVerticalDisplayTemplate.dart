import 'dart:io';

import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:flutter/material.dart';

class DoubleImageVerticalDisplayTemplate extends StatelessWidget {
  final List<File> files;

  const DoubleImageVerticalDisplayTemplate({Key key,@required this.files}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      child: AspectRatio(
        aspectRatio: 0.9,
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(border: Border.all(width: 1.0)),
                width: screenWidth,
                child: AspectRatio(
                  aspectRatio: 1.81,
                  child: Image.file(files[0],fit: BoxFit.cover,alignment: Alignment.topCenter,)
                )),
            Container(
                decoration: BoxDecoration(border: Border.all(width: 1.0)),
                width: screenWidth,
                child: AspectRatio(
                  aspectRatio: 1.81,
                 child: Image.file(files[1],fit: BoxFit.cover,alignment: Alignment.topCenter,)
                ))
          ],
        ),
      ),
    );
  }
}
