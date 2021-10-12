import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/SharePostPageScreen.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/BelowPostCommentDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/CommentsDisplayScreen.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/UserActionsOnPost/OtherUserActionsOnPost.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/UserActionsOnPost/PostOwnerActionsOnPost.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/VideoPostRelatedViews/VideoPostDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OthersProfileModule/views/OtherUserProfilePageScreen.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ReadMoreTextWidget.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/TimeStampProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class SharedVideoPostDisplayTemplate extends StatefulWidget {
  final postContent;
  final parentController;

  const SharedVideoPostDisplayTemplate(
      {Key key, this.postContent, this.parentController})
      : super(key: key);

  @override
  _SharedVideoPostDisplayPostState createState() =>
      _SharedVideoPostDisplayPostState();
}

class _SharedVideoPostDisplayPostState
    extends State<SharedVideoPostDisplayTemplate> {
  String _ownerId;
  String _thisUserId;
  bool _isOwner = false;

  int _numberOfComments = 0;
  int _numberOfReactions = 0;

  List _likes = [];

  @override
  void initState() {
    _ownerId = widget.postContent["postBy"]["_id"].toString();
    _thisUserId = PrimaryUserData.primaryUserData.userId.toString();
    _isOwner = _ownerId == _thisUserId;

    _likes = widget.postContent["likes"];
    _numberOfReactions = _likes.length;
    _numberOfComments = widget.postContent["noOfComments"];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      child: Column(
        children: [
          //basic info of the post
          Container(
            height: 50.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => OtherUserProfilePageScreen(
                        profileOwnerId: widget.postContent["postBy"]["_id"]));
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
                              widget.postContent["postBy"]["profilePic"],
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
                //
                //
                //user name,userName and location
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
                              widget.postContent["postBy"]["name"].toString() +
                                  "  ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15.0),
                            ),
                            // Text(
                            //   widget.postContent["imagePost"]["postBy"]
                            //           ["userName"]
                            //       .toString(),
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.w500, fontSize: 14.0),
                            // ),
                          ],
                        ),
                      ),
                      Container(
                        child: Text(
                          TimeStampProvider.timeStampProvider(
                              widget.postContent["createdAt"].toString()),
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
                //actions on post
                widget.parentController != null
                    ? _isOwner
                        ? PostOwnerActionsOnPost(
                            postId: widget.postContent["_id"].toString(),
                            postDescription: widget
                                .postContent["sharedDescription"]
                                .toString(),
                            editedDescriptionUpdater: (String description) {
                              updateEditedDescription(description);
                            },
                            parentController: widget.parentController,
                          )
                        : OtherUserActionsOnPost(
                            postUserId:
                                widget.postContent["postBy"]["_id"].toString(),
                            postId: widget.postContent["_id"].toString(),
                          )
                    : Container()
              ],
            ),
          ),
          widget.postContent["sharedDescription"] == null
              ? Container()
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  alignment: Alignment.centerLeft,
                  child: ReadMoreText(
                    widget.postContent["sharedDescription"].toString(),
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Theme.of(context).accentColor.withOpacity(0.9)),
                    trimLines: 2,
                    trimCollapsedText: "...more",
                    trimExpandedText: "  less",
                    trimMode: TrimMode.Line,
                    colorClickableText: Colors.blue,
                  ),
                ),
          //original post contents display
          Container(
              margin: EdgeInsets.only(left: 5.0),
              padding: EdgeInsets.only(left: 3.0),
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                          width: 1.0,
                          color:
                              Theme.of(context).accentColor.withOpacity(0.6)))),
              child: GestureDetector(
                onDoubleTap: () {
                  reactionCountUpdater(_thisUserId);
                },
                child: VideoPostDisplayTemplate(
                  postContent: widget.postContent,
                  parentController: widget.parentController,
                ),
              )),
          //like comment and share button container
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

  //edited description updater
  updateEditedDescription(String editedDescription) {
    widget.postContent["sharedDescription"] = editedDescription;
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
