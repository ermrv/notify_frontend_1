import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/10_PostPromotionModule/views/EstimatedBudgetPageScreen.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/SharePostPageScreen.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/BelowPostCommentDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/CommentsDisplayScreen.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/UserActionsOnPost/OtherUserActionsOnPost.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/UserActionsOnPost/PostOwnerActionsOnPost.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/UserProfileScreen.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ReadMoreTextWidget.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/VideoPostRelatedViews/InPostVideoPlayer.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/TimeStampProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

///play a video only for 15 seconds
///
///on tap navigate  to [VideoPostFeedPlayerPageScreen] or [ShortVideoPlayerLayout]
///depending upon the type of the video
class VideoPostDisplayTemplate extends StatefulWidget {
  final postContent;
  final parentController;
  const VideoPostDisplayTemplate(
      {Key key, @required this.postContent,this.parentController})
      : super(key: key);

  @override
  _VideoPostDisplayTemplateState createState() =>
      _VideoPostDisplayTemplateState();
}

class _VideoPostDisplayTemplateState extends State<VideoPostDisplayTemplate> {
  List _likes;
  bool _isOwner = false;
  String _ownerId;
  String _thisUserId;
  bool _isShared = false;
  int _numberOfComments = 0;
  int _numberOfReactions = 0;
  int _numberOfShares = 0;

  @override
  void initState() {
    _ownerId = widget.postContent["videoPost"]["postBy"]["_id"].toString();
    _thisUserId = PrimaryUserData.primaryUserData.userId.toString();
    _isOwner = _ownerId == _thisUserId;
    _likes = widget.postContent["likes"];
    _isShared = widget.postContent["primary"].toString() == "false";
    _numberOfReactions = _likes.length;
    _numberOfComments = widget.postContent["noOfComments"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal:5.0),
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
                          TimeStampProvider.timeStampProvider(
                              widget.postContent["videoPost"]["createdAt"].toString()),
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
             widget.parentController!=null?   _isOwner
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
                        postUserId: widget.postContent["videoPost"]["postBy"]
                                ["_id"]
                            .toString(),
                        postId: widget.postContent["_id"].toString(),
                      ):Container()
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
                    style: TextStyle(fontSize: 16.0),
                    trimLines: 7,
                    trimMode: TrimMode.Line,
                    colorClickableText: Colors.blue,
                  )),

          _isShared
              ? InPostVideoPlayer(
                  postContent: widget.postContent,
                )
              : GestureDetector(
                  onDoubleTap: () {
                    reactionCountUpdater(_thisUserId);
                  },
                  child: InPostVideoPlayer(
                    postContent: widget.postContent,
                  ),
                ),
//total reactions count
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 10.0, left: 8.0,right: 5.0),
            child: _likes.length != 0
                ? Text(
                    "${_likes.length} likes",
                    style: TextStyle(fontSize: 14.0),
                  )
                : Text("Be the first to like",
                    style: TextStyle(fontSize: 14.0)),
          ),
          _isShared
              ? Container()
              : Container(
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
                        alignment:Alignment.center,
                        margin: EdgeInsets.only(right:5.0),
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
                                    color: Colors.white,
                                  ),
                            onPressed: () {
                              reactionCountUpdater(_thisUserId);
                            }),
                      ),
                      //comment
                      Container(
                       height: 40.0,
                        width: 40.0,
                        alignment:Alignment.center,
                        margin: EdgeInsets.only(right:5.0),
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
                        alignment:Alignment.center,
                        margin: EdgeInsets.only(right:5.0),
                        child: IconButton(
                            icon: Icon(MaterialCommunityIcons.share),
                            onPressed: () {
                              Get.to(() => SharePostPageScreen(
                                    postId: widget.postContent["imagePost"]
                                        ["_id"],
                                    postOwnerName:
                                        widget.postContent["imagePost"]
                                            ["postBy"]["name"],
                                    postOwnerProfilePic:
                                        widget.postContent["imagePost"]
                                            ["postBy"]["profilePic"],
                                  ));
                            }),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ),
          _isShared?Container(): widget.postContent["comments"] == null
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
