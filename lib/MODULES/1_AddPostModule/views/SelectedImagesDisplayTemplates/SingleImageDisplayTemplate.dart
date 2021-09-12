import 'dart:io';

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
      child: AspectRatio(
          aspectRatio:aspectRatio<0.8?0.8:aspectRatio,
          child: Image.file(
            imageFile,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          )),
    );
  }
}
