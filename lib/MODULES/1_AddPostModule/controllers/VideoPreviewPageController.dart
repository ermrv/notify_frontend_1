import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewPageController extends GetxController {
  File videoFile;
  double aspectRatio;
  Uint8List thumbImage;
  bool videoIsPlaying = false;

  VideoPlayerController videoPlayerController;
  VideoPlayerController initialisedVideoController;

  initialise() {
    videoPlayerController = VideoPlayerController.file(videoFile);
    videoPlayerController.initialize();
    videoPlayerController.setVolume(0);
  }

  playPauseController() {
    if (videoIsPlaying) {
      videoIsPlaying = false;
      videoPlayerController.pause();
    } else {
      videoIsPlaying = true;
      videoPlayerController.play();
    }

    update();
  }

  sendBackData() {
    Get.back(result: {
      "file": videoFile,
      "aspectRatio": aspectRatio,
      "thumbData": thumbImage
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    super.onClose();
  }
}
