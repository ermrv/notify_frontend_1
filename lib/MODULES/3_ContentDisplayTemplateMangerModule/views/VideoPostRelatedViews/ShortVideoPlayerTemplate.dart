import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/SharePostPageScreen.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/CommentDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/CommentsDisplayScreen.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OthersProfileModule/views/OtherUserProfilePageScreen.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ReadMoreTextWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ShortVideoPlayerTemplate extends StatefulWidget {
  final postContent;
  final parentController;

  const ShortVideoPlayerTemplate(
      {Key key, @required this.postContent, this.parentController})
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
  double _aspectRatio;
  int _numberOfComments = 0;
  int _numberOfReactions = 0;

  VideoPlayerController _videoPlayerController;
  @override
  void initState() {
//initialise variables
    _ownerId = widget.postContent["videoPost"]["postBy"]["_id"].toString();
    _thisUserId = PrimaryUserData.primaryUserData.userId.toString();
    _isOwner = _ownerId == _thisUserId;
    _likes = widget.postContent["likes"];
    _numberOfReactions = _likes.length;
    _numberOfComments = widget.postContent["noOfComments"];

    //initialise video controller
    _videoPlayerController = VideoPlayerController.network(ApiUrlsData.domain +
        widget.postContent["videoPost"]["postContent"][0]["path"].toString());
    _videoPlayerController.initialize();
    _videoPlayerController.play();
    _aspectRatio = widget.postContent["videoPost"]["aspectRatio"] != null
        ? double.parse(
            widget.postContent["videoPost"]["aspectRatio"].toString())
        : _videoPlayerController.value.aspectRatio;
    _videoPlayerController.setLooping(true);
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
        alignment: AlignmentDirectional.center,
        children: [
          GestureDetector(
            onDoubleTap: () {
              reactionCountUpdater(_thisUserId);
            },
            onTap: () {
              _videoPlayerController.value.isPlaying
                  ? _videoPlayerController.pause()
                  : _videoPlayerController.play();

              if (this.mounted) {
                setState(() {});
              }
            },
            child: Container(
                alignment: Alignment.center,
                width: screenWidth,
                height: screenHeight,
                child: AspectRatio(
                    aspectRatio: _aspectRatio,
                    child: VideoPlayer(_videoPlayerController))),
          ),
          _videoPlayerController.value.isPlaying
              ? Container()
              : Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(50.0),
                        border: Border.all(width: 2.0, color: Colors.white)),
                    child: IconButton(
                      icon: Icon(Icons.play_arrow),
                      iconSize: 32.0,
                      onPressed: () {
                        _videoPlayerController.play();
                        if (this.mounted) {
                          setState(() {});
                        }
                      },
                    ),
                  ),
                ),
          Positioned(
            bottom: 15.0,
            right: 0.0,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 4.0),
              child: Column(
                children: [
                  //profile picture
                  GestureDetector(
                    onTap: () {
                      Get.to(() => OtherUserProfilePageScreen(
                          profileOwnerId: widget.postContent["videoPost"]
                              ["postBy"]["_id"]));
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                      height: 45.0,
                      width: 45.0,
                      padding: EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          color: Colors.deepOrange[900]),
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
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(25.0)),
                            child: _likes.contains(_thisUserId)
                                ? Icon(
                                    Octicons.heart,
                                    size: 32.0,
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
                      Get.to(
                        () => CommentsDisplayScreen(
                          postId: widget.postContent["_id"],
                          commentCountUpdater: (int count) {
                            commentCountUpdater(count);
                          },
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
                                color: Colors.black12,
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
                        GestureDetector(
                          onTap: () {
                            _videoPlayerController.pause();
                            Get.to(() => SharePostPageScreen(
                                  postId: widget.postContent["videoPost"]
                                      ["_id"],
                                  postOwnerName: widget.postContent["videoPost"]
                                      ["postBy"]["name"],
                                  postOwnerProfilePic:
                                      widget.postContent["videoPost"]["postBy"]
                                          ["profilePic"],
                                ));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.0, vertical: 4.0),
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(25.0)),
                            child: Icon(
                              MaterialCommunityIcons.share,
                              size: 32.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 20.0,
                  )
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(left: 5.0),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(bottom: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Text(
                            "@" +
                                widget.postContent["videoPost"]["postBy"]
                                        ["name"]
                                    .toString(),
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 25.0,
                          child: _getFollowButton(
                              widget.postContent["videoPost"]["postBy"]["_id"],
                              false),
                        )
                      ],
                    ),
                    //description and tags container
                    widget.postContent["videoPost"]["description"] == null ||
                            widget.postContent["videoPost"]["description"] == ""
                        ? Container()
                        : Container(
                            width: screenWidth,
                            padding: EdgeInsets.only(
                                top: 3.0, bottom: 3.0, right: 2.0, left: 2.0),
                            alignment: Alignment.centerLeft,
                            child: ReadMoreText(
                              widget.postContent["videoPost"]["description"]
                                  .toString()
                                  .capitalizeFirst,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.9)),
                              trimLines: 2,
                              trimCollapsedText: "...more",
                              trimExpandedText: "  less",
                              trimMode: TrimMode.Line,
                              colorClickableText: Colors.blue,
                            )),
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

  //reaction count updater
  reactionCountUpdater(String userId) async {
    if (_likes.contains(userId)) {
      _likes.remove(userId);
      setState(() {
        _numberOfReactions = _likes.length;
      });
      var response = await ApiServices.postWithAuth(ApiUrlsData.postReaction,
          {"postId": widget.postContent["_id"], "like": false}, userToken);
      if (response == "error") {
        Get.snackbar("Somethings wrong", "Your reaction is not updated");
      }
    } else {
      _likes.add(userId);
      setState(() {
        _numberOfReactions = _likes.length;
      });
      var response = await ApiServices.postWithAuth(ApiUrlsData.postReaction,
          {"postId": widget.postContent["_id"], "like": true}, userToken);
      if (response == "error") {
        Get.snackbar("Somethings wrong", "Your reaction is not updated");
      }
    }
  }

  //...................................follow and else updater..................
  _followUser(String userId) async {
    PrimaryUserData.primaryUserData.followings.add(userId);
    setState(() {});
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.followUser, {"userId": userId}, userToken);
    if (response != "error") {
      try {
        PrimaryUserData.primaryUserData.deleteLocalUserBasicDataFile();
      } catch (e) {
        print(e);
      }
    }
  }

  _unFollowUser(String userId) async {
    PrimaryUserData.primaryUserData.followings.remove(userId);
    setState(() {});
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.unfollowUser, {"userId": userId}, userToken);
    if (response != "error") {
      try {
        PrimaryUserData.primaryUserData.deleteLocalUserBasicDataFile();
      } catch (e) {
        print(e);
      }
    }
  }

  TextButton _getFollowButton(String userId, bool isCenterAligned) {
    if (PrimaryUserData.primaryUserData.followings.contains(userId)) {
      return TextButton(
          child: isCenterAligned
              ? Container(alignment: Alignment.center, child: Text("Unfollow"))
              : Container(child: Text("Unfollow")),
          onPressed: () {
            _unFollowUser(userId);
          });
    } else if (PrimaryUserData.primaryUserData.followers.contains(userId)) {
      return TextButton(
          child: isCenterAligned
              ? Container(
                  alignment: Alignment.center, child: Text("Follow Back"))
              : Container(child: Text("Follow Back")),
          onPressed: () {
            _followUser(userId);
          });
    } else {
      return TextButton(
          child: isCenterAligned
              ? Container(alignment: Alignment.center, child: Text("Follow"))
              : Container(child: Text("Follow")),
          onPressed: () {
            _followUser(userId);
          });
    }
  }
}
