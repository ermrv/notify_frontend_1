import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/SharePostPageScreen.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/BelowPostCommentDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/CommentsDisplayScreen.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ImagePostRelatedViews/ImagePostDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/PostLikesDisplayPageScreen.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/SpecificPostRelated/views/SpecificPostDisplayPageScreen.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/UserActionsOnPost/OtherUserActionsOnPost.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/UserActionsOnPost/PostOwnerActionsOnPost.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OthersProfileModule/views/OtherUserProfilePageScreen.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OwnProfileModule/views/OwnProfilePageScreen.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/UserProfileScreen.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/IntegerParser.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ReadMoreTextWidget.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/PostDescriptionWidget.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/TimeStampProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:share/share.dart';

class SharedImagePostDisplayTemplate extends StatefulWidget {
  final postContent;
  final parentController;
  final bool useAsPostFullDetailTemplate;
  const SharedImagePostDisplayTemplate(
      {Key key,
      @required this.postContent,
      this.parentController,
      @required this.useAsPostFullDetailTemplate})
      : super(key: key);

  @override
  _SharedImagePostDisplayTemplateState createState() =>
      _SharedImagePostDisplayTemplateState();
}

class _SharedImagePostDisplayTemplateState
    extends State<SharedImagePostDisplayTemplate> {
  //post privacy
  bool commenting = false;
  bool sharing = false;
  //ownership of the post
  String _ownerId;
  String _thisUserId;
  bool _isOwner = false;

  ///post informations
  int _numberOfComments = 0;
  int _numberOfReactions = 0;
  int _numberOfShare;

  List _likes = [];

  //when the post delete is clicked
  bool _postRemoved = false;

  @override
  void initState() {
    //post privacy
    commenting = widget.postContent["commentOption"].toString() == "true";
    sharing = widget.postContent["sharingOption"].toString() == "true";
    //ownership of the post
    _ownerId = widget.postContent["postBy"]["_id"].toString();
    _thisUserId = PrimaryUserData.primaryUserData.userId.toString();
    _isOwner = _ownerId == _thisUserId;

    //post informations
    _likes = widget.postContent["likes"];
    _numberOfReactions = _likes.length;
    _numberOfComments = widget.postContent["noOfComments"];
    _numberOfShare = widget.postContent["noOfShares"];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      child: _postRemoved
          ? Container()
          : Column(
              children: [
                //basic info of the post
                Container(
                  height: 50.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //
                      //
                      //user profile pic
                      GestureDetector(
                        onTap: () {
                          Get.to(() => UserProfileScreen(
                              profileOwnerId: widget.postContent["postBy"]
                                  ["_id"]));
                        },
                        child: Container(
                          padding: EdgeInsets.all(1.0),
                          height: 35.0,
                          width: 35.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.deepOrange[900]),
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
                                    widget.postContent["postBy"]["name"]
                                            .toString() +
                                        "  ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.0),
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
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.0),
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
                                  editedDescriptionUpdater:
                                      (String description) {
                                    updateEditedDescription(description);
                                  },
                                  parentController: widget.parentController,
                                  removePost: () {
                                    _removePost();
                                  },
                                )
                              : OtherUserActionsOnPost(
                                  postUserId: widget.postContent["postBy"]
                                          ["_id"]
                                      .toString(),
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
                        child: GestureDetector(
                          onDoubleTap: () {
                            reactionCountUpdater(_thisUserId);
                          },
                          onTap: () {
                            if (!widget.useAsPostFullDetailTemplate) {
                              Get.to(
                                  () => SpecificPostDisplayPageScreen(
                                      postId: widget.postContent["_id"],
                                      postContent: widget.postContent),
                                  preventDuplicates: false);
                            }
                          },
                          child: PostDescriptionWidget(
                              tags: [],
                              mentions: [],
                              description: widget
                                  .postContent["sharedDescription"]
                                  .toString(),
                              postType: "sharedPost",
                              displayFullText:
                                  widget.useAsPostFullDetailTemplate),
                        )),
                //original post contents display
                Container(
                    margin: EdgeInsets.only(left: 5.0),
                    padding: EdgeInsets.only(left: 3.0),
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(
                                width: 1.0,
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.6)))),
                    child: GestureDetector(
                      onDoubleTap: () {
                        reactionCountUpdater(_thisUserId);
                      },
                      child: ImagePostDisplayTemplate(
                        postContent: widget.postContent,
                        parentController: widget.parentController,
                        useAsPostFullDetailTemplate: false,
                      ),
                    )),
                //likes count
                Container(
                  alignment: Alignment.centerLeft,
                  child: _likes.length != 0
                      ? GestureDetector(
                          onTap: () {
                            Get.to(() => PostLikesDisplayPageScreen(
                                postId: widget.postContent["_id"]));
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 10.0, left: 8.0, right: 8.0),
                            child: Text(
                              "${_likes.length} likes",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        )
                      : Container(
                          margin:
                              EdgeInsets.only(top: 10.0, left: 8.0, right: 8.0),
                          child: Text("Be the first to like",
                              style: TextStyle(fontSize: 14.0)),
                        ),
                ),
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
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 3.0),
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
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                            onPressed: () {
                              reactionCountUpdater(_thisUserId);
                            }),
                      ),
                       Container(
                                margin: EdgeInsets.only(right: 5.0),
                                child: Text(integerParser(_numberOfReactions)),
                              ),
                      //comment
                      Container(
                        height: 40.0,
                        width: 40.0,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 3.0),
                        child: IconButton(
                            padding: EdgeInsets.all(4.0),
                            icon: Icon(EvilIcons.comment,
                                size: 28.0,
                                color: commenting
                                    ? Theme.of(context).iconTheme.color
                                    : Theme.of(context)
                                        .iconTheme
                                        .color
                                        .withOpacity(0.2)),
                            onPressed: () {
                              if (commenting) {
                                Get.to(() => CommentsDisplayScreen(
                                      postId: widget.postContent["_id"],
                                      commentCountUpdater: (int commentCount) {
                                        commentCountUpdater(commentCount);
                                      },
                                    ));
                              }
                            }),
                      ),
                       Container(
                                margin: EdgeInsets.only(right: 5.0),
                                child: Text(integerParser(_numberOfComments),
                                    style: TextStyle(
                                        color: commenting
                                            ? Theme.of(context).iconTheme.color
                                            : Theme.of(context)
                                                .iconTheme
                                                .color
                                                .withOpacity(0.2))),
                              ),
                              //share...............................
                      Container(
                        height: 40.0,
                        width: 40.0,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 3.0),
                        child: IconButton(
                            icon: Icon(MaterialCommunityIcons.share,
                                color: sharing
                                    ? Theme.of(context).iconTheme.color
                                    : Theme.of(context)
                                        .iconTheme
                                        .color
                                        .withOpacity(0.2)),
                            onPressed: () {
                              if (sharing) {
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
                              }
                            }),
                      ),
                      Container(
                                margin: EdgeInsets.only(right: 5.0),
                                child: Text(
                                  integerParser(_numberOfShare),
                                  style: TextStyle(
                                      color: sharing
                                          ? Theme.of(context).iconTheme.color
                                          : Theme.of(context)
                                              .iconTheme
                                              .color
                                              .withOpacity(0.2)),
                                ),
                              ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ),
                widget.postContent["comments"] == null || !commenting
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

//remove post
  _removePost() {
    setState(() {
      _postRemoved = true;
    });
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
