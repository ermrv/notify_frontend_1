import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/CommentsDisplayManagerModule/views/CommentDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/CommentsDisplayManagerModule/views/CommentsDisplayScreen.dart';
import 'package:MediaPlus/MODULES/UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ShortVideoPlayerTemplate extends StatefulWidget {
  final postContent;

  const ShortVideoPlayerTemplate({Key key, @required this.postContent})
      : super(key: key);

  @override
  _ShortVideoPlayerTemplateState createState() =>
      _ShortVideoPlayerTemplateState();
}

class _ShortVideoPlayerTemplateState extends State<ShortVideoPlayerTemplate> {
  List _likes;
  bool _isOwner = false;
  String _ownerId;
  String _thisUserId;

  int _numberOfComments = 0;
  int _numberOfReactions = 0;
  int _numberOfShares = 0;

  VideoPlayerController _videoPlayerController;
  @override
  void initState() {
//initialise variables
    _ownerId = widget.postContent["videoPost"]["postBy"]["_id"].toString();
    _thisUserId = PrimaryUserData.primaryUserData.userId.toString();
    _isOwner = _ownerId == _thisUserId;
    _likes = widget.postContent["likes"];
    _numberOfReactions = _likes.length;

    //initialise video controller
    _videoPlayerController = VideoPlayerController.network(ApiUrlsData.domain +
        widget.postContent["videoPost"]["postContent"][0]["path"].toString());
    _videoPlayerController.initialize();
    _videoPlayerController.play();
    super.initState();
  }

  @override
  void dispose() {
    // SystemChrome.setEnabledSystemUIOverlays(
    //     [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          GestureDetector(
            onDoubleTap: () {
              reactionCountUpdater(_thisUserId);
            },
            child: Container(
                alignment: Alignment.center,
                width: screenWidth,
                height: screenHeight,
                child: VideoPlayer(_videoPlayerController)),
          ),
          Positioned(
            bottom: 15.0,
            right: 0.0,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 4.0),
              child: Column(
                children: [
                  //profile picture
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                    height: 45.0,
                    width: 45.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: CachedNetworkImage(
                        imageUrl: ApiUrlsData.domain +
                            widget.postContent["videoPost"]["postBy"]
                                ["profilePic"],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                  //like
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            reactionCountUpdater(_thisUserId);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.0, vertical: 4.0),
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(25.0)),
                            child: _likes.contains(_thisUserId)
                                ? Icon(
                                  Octicons.heart,
                                  size: 28.0,
                                  color: Colors.red,
                                )
                              : Icon(
                                  EvilIcons.heart,
                                  size: 32.0,
                                  color: Colors.white,
                                ),
                          ),
                        ),
                        Text(
                          _numberOfReactions.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  //comments
                  GestureDetector(
                    onTap: () {
                      _videoPlayerController.pause();
                      setState(() {});
                      Get.to(()=>
                        CommentsDisplayScreen(
                        postId: widget.postContent["_id"],
                      ),
                      ).then((value) {
                        setState(() {
                          _videoPlayerController.play();
                        });
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.0, vertical: 4.0),
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(25.0)),
                            child: Icon(
                              EvilIcons.comment,
                              size: 32.0,
                            ),
                          ),
                          Text(_numberOfComments.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ),
                  //share
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 4.0),
                          decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(25.0)),
                          child: Icon(
                            MaterialCommunityIcons.share,
                            size: 32.0,
                          ),
                        ),
                        Text(_numberOfShares.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(left: 5.0),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(bottom: 4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "@" +
                          widget.postContent["videoPost"]["postBy"]["name"]
                              .toString(),
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    // Container(
                    //   child: Wrap(
                    //     children: [
                    //       Text(
                    //         widget.postContent["description"],
                    //         style: TextStyle(color: Colors.white),
                    //       ),
                    //       for (var i in widget.postContent["hashtags"])
                    //         Text(" #" + i.toString(),
                    //             style: TextStyle(color: Colors.white))
                    //     ],
                    //   ),
                    // ),
                    Container(
                      child: Text(
                        "12k views",
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  commentCountUpdater(int count) {
    setState(() {
      _numberOfComments = count;
    });
  }

  reactionCountUpdater(String userId) {
    if (_likes.contains(userId)) {
      _likes.remove(userId);
      setState(() {
        _numberOfReactions = _likes.length;
      });
    } else {
      _likes.add(userId);
      setState(() {
        _numberOfReactions = _likes.length;
      });
    }
  }
}
