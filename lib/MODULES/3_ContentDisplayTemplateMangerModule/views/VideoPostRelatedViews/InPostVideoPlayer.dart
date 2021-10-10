import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/17_ShortVideoPlayerModule/views/ShortVideoPlayerPageScreen.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/VideoPostRelatedViews/VideoPostFeedPlayerPageScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class InPostVideoPlayer extends StatefulWidget {
  final postContent;

  InPostVideoPlayer({Key key, @required this.postContent}) : super(key: key);

  @override
  _InPostVideoPlayerState createState() => _InPostVideoPlayerState();
}

class _InPostVideoPlayerState extends State<InPostVideoPlayer> {
  VideoPlayerController _videoPlayerController;
  double _aspectRatio = 0.8;
  bool _showVideoPlayer = false;
  bool showFullVideoPlayerButton = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _aspectRatio,
      child: GestureDetector(
        onTap: () {
          if (widget.postContent["videoPost"]["shortVideo"].toString() ==
              "true") {
            Get.to(() =>
                ShortVideoPlayerPageScreen(postContent: widget.postContent));
          } else {
            Get.to(() => VideoPostFeedPlayerPageScreen(
                  postContent: widget.postContent,
                ));
          }
        },
        child: VisibilityDetector(
          key: Key(widget.postContent["videoPost"]["postContent"][0]["_id"]
              .toString()),
          onVisibilityChanged: (info) {
            _onVisibilityChangeController(info);
          },
          child: _showVideoPlayer
              ? Container(
                  width: screenWidth,
                  child: Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: _aspectRatio,
                        child: VideoPlayer(_videoPlayerController),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: _videoPlayerController.value.isPlaying ||
                                showFullVideoPlayerButton
                            ? Container()
                            : IconButton(
                                onPressed: () {
                                  try {
                                    _videoPlayerController.play();
                                  } catch (e) {}
                                },
                                icon: Icon(Icons.play_arrow)),
                      ),
                      Positioned(
                        bottom: 3.0,
                        right: 3.0,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black12, shape: BoxShape.circle),
                          child: IconButton(
                              color: Colors.black,
                              icon: _videoPlayerController.value.volume == 0.0
                                  ? Icon(
                                      Icons.volume_off,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      Icons.volume_up,
                                      color: Colors.white,
                                    ),
                              onPressed: () {
                                _soundController();
                              }),
                        ),
                      ),
                      Positioned(
                          bottom: 0.0,
                          child: Container(
                              width: screenWidth,
                              child: VideoProgressIndicator(
                                _videoPlayerController,
                                allowScrubbing: true,
                              ))),
                      Positioned(
                          bottom: 0.0,
                          child: showFullVideoPlayerButton
                              ? Container(
                                  width: screenWidth * 0.98,
                                  alignment: Alignment.center,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.7),
                                    border: Border(),
                                  ),
                                  child: Text(
                                    "Play Full Video",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )
                              : Container()),
                    ],
                  ),
                )
              : Container(
                  child: Stack(
                    children: [
                      Container(
                        width: screenWidth,
                        child: CachedNetworkImage(
                          imageUrl: ApiUrlsData.domain +
                              widget.postContent["videoPost"]["thumbnail"]
                                  .toString(),
                          placeholder: (context, string) => Container(
                            width: screenWidth,
                            height: screenWidth,
                          ),
                          alignment: Alignment.topCenter,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: IconButton(
                          icon: Icon(Icons.play_arrow),
                          onPressed: () {
                            _initialiseVideoPlayer();
                            setState(() {
                              _showVideoPlayer = true;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  _onVisibilityChangeController(VisibilityInfo info) {
    if (info.visibleFraction >= 0.8) {
      if (!_showVideoPlayer) {
        _initialiseVideoPlayer();
        setState(() {
          _showVideoPlayer = true;
        });
      }
    } else {
      try {
        _videoPlayerController.pause();
      } catch (e) {
        print(e);
      }
      setState(() {
        _showVideoPlayer = false;
      });
    }
  }

  _initialiseVideoPlayer() {
    _videoPlayerController = VideoPlayerController.network(ApiUrlsData.domain +
        widget.postContent["videoPost"]["postContent"][0]["path"].toString());

    _videoPlayerController.initialize();
    _videoPlayerController.setVolume(0.5);

    _videoPlayerController.play();
    if (widget.postContent["videoPost"]["shortVideo"].toString() == "true") {
      _videoPlayerController.setLooping(true);
    }
    _videoPlayerController.addListener(() {
      _videoPlayerControllerListener();
    });

    _aspectRatio =
        double.parse(widget.postContent["videoPost"]["aspectRatio"].toString());
  }

  _playPauseControl() {
    if (_videoPlayerController.value.isPlaying) {
      if (this.mounted) {
        setState(() {
          _videoPlayerController.pause();
        });
      }
    } else if (!_videoPlayerController.value.isPlaying) {
      if (this.mounted) {
        setState(() {
          _videoPlayerController.play();
        });
      }
    }
  }

  _soundController() {
    if (_videoPlayerController.value.volume == 0.0) {
      if (this.mounted) {
        setState(() {
          _videoPlayerController.setVolume(1.0);
        });
      }
    } else if (_videoPlayerController.value.volume == 1.0) {
      if (this.mounted) {
        setState(() {
          _videoPlayerController.setVolume(0.0);
        });
      }
    }
  }

  _videoPlayerControllerListener() async {
    if (_videoPlayerController.value.position.inSeconds >= 20) {
      if (_videoPlayerController.value.isPlaying) {
        _videoPlayerController.pause();
      }
      showFullVideoPlayerButton = true;
      if (this.mounted) {
        setState(() {});
      }
    }
  }
}
