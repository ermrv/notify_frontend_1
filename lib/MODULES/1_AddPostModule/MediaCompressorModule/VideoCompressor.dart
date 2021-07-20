import 'dart:io';
import 'dart:typed_data';

import 'package:video_compress/video_compress.dart';

///TODO CHANGE THIS BULLSHIT PACKAGE
abstract class VideoCompressor {
  ///returns the compressed video as Uint8List
  ///
  static Future<Uint8List> compressVideo(File videoFile) async {
    Uint8List video;
    try {
      MediaInfo mediaInfo = await VideoCompress.compressVideo(
        videoFile.path,
        quality: VideoQuality.LowQuality,
        frameRate: 24,
        includeAudio: true,
        deleteOrigin: false, // It's false by default
      );
      video = await mediaInfo.file.readAsBytes();
    } catch (e) {
      print(e);
      video = await videoFile.readAsBytes();
    }

    return video;
  }
}
