import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/VideoPostRelatedViews/VideoPostFeedPlayerPageScreen.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

///play a video only for 15 seconds
///
///on tap navigate  to [VideoPostFeedPlayerPageScreen] or [ShortVideoPlayerLayout]
///depending upon the type of the video
class FullVideoPostPlayerTemplate extends StatefulWidget {
  final postContent;
  // final String id;
  final parentController;
  const FullVideoPostPlayerTemplate(
      {Key key, @required this.postContent, this.parentController})
      : super(key: key);

  @override
  _FullVideoPostPlayerTemplateState createState() =>
      _FullVideoPostPlayerTemplateState();
}

class _FullVideoPostPlayerTemplateState
    extends State<FullVideoPostPlayerTemplate> {
  List _likes;

  String _ownerId;
  String _thisUserId;

  FlickManager flickManager;

  double _aspectRatio;

  @override
  void initState() {
    //initialise variables
    _ownerId = widget.postContent["videoPost"]["postBy"]["_id"].toString();
    _thisUserId = PrimaryUserData.primaryUserData.userId.toString();

    _likes = widget.postContent["likes"];

    _aspectRatio =
        double.parse(widget.postContent["videoPost"]["aspectRatio"].toString());

    _initialiseVideoPlayer();

    super.initState();
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: AspectRatio(
              aspectRatio: _aspectRatio,
              child: Container(
                child: FlickVideoPlayer(
                  flickManager: flickManager,
                  flickVideoWithControlsFullscreen: FlickVideoWithControls(
                    controls: FlickLandscapeControls(),
                  ),
                  flickVideoWithControls: FlickVideoWithControls(
                    controls: FlickPortraitControls(),
                  ),
                ),
              ))),
    );
  }
//total reactions count

  ///initialise video player
  _initialiseVideoPlayer() {
    flickManager = FlickManager(
        autoPlay: true,
        autoInitialize: true,
        videoPlayerController: VideoPlayerController.network(
            ApiUrlsData.domain +
                widget.postContent["videoPost"]["postContent"][0]["path"]
                    .toString()));

    _aspectRatio = widget.postContent["videoPost"]["aspectRatio"] != null
        ? double.parse(
            widget.postContent["videoPost"]["aspectRatio"].toString())
        : flickManager
            .flickVideoManager.videoPlayerController.value.aspectRatio;
  }
}
