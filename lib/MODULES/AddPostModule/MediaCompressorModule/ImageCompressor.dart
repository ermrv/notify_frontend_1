import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';

abstract class ImageCompressor {
  static Future<List<Uint8List>> compressImages(List<File> images) async {
    List<Uint8List> compressedImages = [];
    for (File file in images)
      try {
        int fileSize = await file.length();
        int targetSize = 60000;
        int quality =100-(fileSize / targetSize).ceil();
        Uint8List result = await FlutterImageCompress.compressWithFile(
          file.absolute.path,
         
          quality:25,
        );
        compressedImages.add(result);
      } catch (e) {
        print(e);
        compressedImages.add(file.readAsBytesSync());
      }

    return compressedImages;
  }
}
