import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/10_PostPromotionModule/views/EstimatedBudgetPageScreen.dart';
import 'package:MediaPlus/MODULES/17_ShortVideoPlayerModule/views/ShortVideoPlayerPageScreen.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/SharePostPageScreen.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/BelowPostCommentDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/CommentsDisplayScreen.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/PostLikesDisplayPageScreen.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/UserActionsOnPost/OtherUserActionsOnPost.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/UserActionsOnPost/PostOwnerActionsOnPost.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/VideoPostRelatedViews/VideoPostFeedPlayerPageScreen.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/UserProfileScreen.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ReadMoreTextWidget.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/TimeStampProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

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
  bool _isOwner = false;
  String _ownerId;
  String _thisUserId;

  int _numberOfComments = 0;
  int _numberOfReactions = 0;

  FlickManager flickManager;

  double _aspectRatio;
  bool _showVideoPlayer = false;

  @override
  void initState() {
    //initialise variables
    _ownerId = widget.postContent["videoPost"]["postBy"]["_id"].toString();
    _thisUserId = PrimaryUserData.primaryUserData.userId.toString();
    _isOwner = _ownerId == _thisUserId;
    _likes = widget.postContent["likes"];
    _numberOfReactions = _likes.length;
    _numberOfComments = widget.postContent["noOfComments"];

    _aspectRatio =
        double.parse(widget.postContent["videoPost"]["aspectRatio"].toString());

    super.initState();
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //post details like user profile pic and name
          Container(
            height: 60.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => UserProfileScreen(
                          profileOwnerId: widget.postContent["videoPost"]
                              ["postBy"]["_id"],
                        ));
                  },
                  child: Container(
                    padding: EdgeInsets.all(1.0),
                    height: 35.0,
                    width: 35.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.deepOrange[900]),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: CachedNetworkImage(
                          imageUrl: ApiUrlsData.domain +
                              widget.postContent["videoPost"]["postBy"]
                                  ["profilePic"],
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 2.0),
                        child: Row(
                          children: [
                            Text(
                              widget.postContent["videoPost"]["postBy"]["name"]
                                      .toString() +
                                  "  ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15.0),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Text(
                          TimeStampProvider.timeStampProvider(widget
                              .postContent["videoPost"]["createdAt"]
                              .toString()),
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12.0),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                _isOwner
                    ? Container(
                        child: TextButton(
                          onPressed: () {
                            Get.to(() => EstimatedBudgetPageScreen(
                                  postId: widget.postContent["_id"].toString(),
                                ));
                          },
                          child: Text("Promote"),
                        ),
                      )
                    : Container(),
                //actions on post
                widget.parentController != null
                    ? _isOwner
                        ? PostOwnerActionsOnPost(
                            postId: widget.postContent["_id"].toString(),
                            postDescription: widget.postContent["videoPost"]
                                    ["description"]
                                .toString(),
                            editedDescriptionUpdater: (String description) {
                              updateEditedDescription(description);
                            },
                            parentController: widget.parentController,
                          )
                        : OtherUserActionsOnPost(
                            postUserId: widget.postContent["videoPost"]
                                    ["postBy"]["_id"]
                                .toString(),
                            postId: widget.postContent["_id"].toString(),
                          )
                    : Container()
              ],
            ),
          ),
          //caption container
          widget.postContent["videoPost"]["description"] == null ||
                  widget.postContent["videoPost"]["description"] == ""
              ? Container()
              : Container(
                  width: screenWidth,
                  padding: EdgeInsets.only(
                      top: 3.0, bottom: 3.0, right: 2.0, left: 2.0),
                  alignment: Alignment.centerLeft,
                  child: ReadMoreText(
                    widget.postContent["videoPost"]["description"].toString(),
                    style: TextStyle(fontSize: 15.0),
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    colorClickableText: Colors.blue,
                  )),

          VisibilityDetector(
              key: Key(widget.postContent["_id"].toString() +
                  widget.postContent["createdAt"].toString()),
              onVisibilityChanged: (info) {
                _onVisibilityChangeController(info);
              },
              child: _showVideoPlayer
                  ? AspectRatio(
                      aspectRatio: _aspectRatio,
                      child: Container(
                        child: FlickVideoPlayer(
                          flickManager: flickManager,
                          flickVideoWithControlsFullscreen:
                              FlickVideoWithControls(
                            controls: FlickLandscapeControls(),
                          ),
                          flickVideoWithControls: FlickVideoWithControls(
                            controls: FlickPortraitControls(),
                          ),
                        ),
                      ),
                    )
                  : AspectRatio(
                      aspectRatio: _aspectRatio,
                      child: Container(
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              width: screenWidth,
                              child: CachedNetworkImage(
                                imageUrl: ApiUrlsData.domain +
                                    widget.postContent["videoPost"]
                                            ["postContent"][0]["thumbnail"]
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
                              child: Container(
                                height: 50.0,
                                width: 50.0,
                                decoration: BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius: BorderRadius.circular(50.0),
                                    border: Border.all(
                                        width: 2.0, color: Colors.white)),
                                child: IconButton(
                                  icon: Icon(Icons.play_arrow),
                                  iconSize: 32.0,
                                  onPressed: () {
                                    _initialiseVideoPlayer();
                                    setState(() {
                                      _showVideoPlayer = true;
                                    });
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
//total reactions count
          Container(
            alignment: Alignment.centerLeft,
            child: _likes.length != 0
                ? GestureDetector(
                    onTap: () {
                      Get.to(() => PostLikesDisplayPageScreen(
                          postId: widget.postContent["_id"]));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 8.0, right: 8.0),
                      child: Text(
                        "${_likes.length} likes",
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(top: 10.0, left: 8.0, right: 8.0),
                    child: Text("Be the first to like",
                        style: TextStyle(fontSize: 14.0)),
                  ),
          ),
          Container(
            height: 50.0,
            width: screenWidth,
            padding: EdgeInsets.symmetric(horizontal: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //like
                Container(
                  height: 40.0,
                  width: 40.0,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 5.0),
                  child: IconButton(
                      padding: EdgeInsets.all(4.0),
                      icon: _likes.contains(
                        _thisUserId,
                      )
                          ? Icon(
                              Octicons.heart,
                              size: 24.0,
                              color: Colors.red,
                            )
                          : Icon(
                              EvilIcons.heart,
                              size: 28.0,
                              color:Theme.of(context).iconTheme.color,
                            ),
                      onPressed: () {
                        reactionCountUpdater(_thisUserId);
                      }),
                ),
                //comment
                Container(
                  height: 40.0,
                  width: 40.0,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 5.0),
                  child: IconButton(
                      padding: EdgeInsets.all(4.0),
                      icon: Icon(
                        EvilIcons.comment,
                        size: 28.0,
                      ),
                      onPressed: () {
                        Get.to(() => CommentsDisplayScreen(
                              postId: widget.postContent["_id"],
                              commentCountUpdater: (int commentCount) {
                                commentCountUpdater(commentCount);
                              },
                            ));
                      }),
                ),
                Container(
                  height: 40.0,
                  width: 40.0,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 5.0),
                  child: IconButton(
                      icon: Icon(MaterialCommunityIcons.share),
                      onPressed: () {
                        Get.to(() => SharePostPageScreen(
                              postId: widget.postContent["imagePost"]["_id"],
                              postOwnerName: widget.postContent["imagePost"]
                                  ["postBy"]["name"],
                              postOwnerProfilePic:
                                  widget.postContent["imagePost"]["postBy"]
                                      ["profilePic"],
                            ));
                      }),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
          widget.postContent["comments"] == null
              ? Container()
              : widget.postContent["comments"].length == 0
                  ? Container()
                  : BelowPostCommentDisplayTemplate(
                      commentCount: _numberOfComments,
                      commentData: widget.postContent["comments"][0],
                      postId: widget.postContent["_id"],
                      commentCountUpdater: (int count) {
                        commentCountUpdater(count);
                      },
                    )
        ],
      ),
    );
  }

  ///visibility change controller
  _onVisibilityChangeController(VisibilityInfo info) {
    if (info.visibleFraction >= 0.9) {
      if (!_showVideoPlayer) {
        _initialiseVideoPlayer();
        if (this.mounted) {
          setState(() {
            _showVideoPlayer = true;
          });
        }
      } else if (_showVideoPlayer &&
          !flickManager.flickVideoManager.isPlaying) {
        flickManager.flickControlManager.play();
        if (this.mounted) {
          setState(() {});
        }
      }
    } else {
      try {
        flickManager.flickControlManager.pause();
      } catch (e) {
        print(e);
      }
    }
  }

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

  //edited description updater
  updateEditedDescription(String editedDescription) {
    widget.postContent["videoPost"]["description"] = editedDescription;
    if (this.mounted) {
      setState(() {});
    }
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
}
