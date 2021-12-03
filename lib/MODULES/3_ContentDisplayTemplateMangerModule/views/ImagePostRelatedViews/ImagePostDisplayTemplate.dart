import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/10_PostPromotionModule/views/EstimatedBudgetPageScreen.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/SharePostPageScreen.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/BelowPostCommentDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/CommentsDisplayScreen.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ImagePostRelatedViews/ImageDisplayTemplates/DuobleImageHorizontalDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ImagePostRelatedViews/ImageDisplayTemplates/DuobleImageVerticalDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ImagePostRelatedViews/ImageDisplayTemplates/ImageCarouselDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ImagePostRelatedViews/ImageDisplayTemplates/MultiImageHorizontalDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ImagePostRelatedViews/ImageDisplayTemplates/MultiImageVerticalDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ImagePostRelatedViews/ImageDisplayTemplates/SingleImageDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/PostLikesDisplayPageScreen.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/SpecificPostRelated/views/SpecificPostDisplayPageScreen.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/UserActionsOnPost/OtherUserActionsOnPost.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/UserActionsOnPost/PostOwnerActionsOnPost.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/UserProfileScreen.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';

import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/PostDescriptionWidget.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/TimeStampProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

///widget to dispaly the image posts, given [postContent]
class ImagePostDisplayTemplate extends StatefulWidget {
  final postContent;
  final parentController;
  final bool useAsPostFullDetailTemplate;
  ImagePostDisplayTemplate(
      {Key key,
      this.postContent,
      this.parentController,
      @required this.useAsPostFullDetailTemplate})
      : super(key: key);

  @override
  _ImagePostDisplayTemplateState createState() =>
      _ImagePostDisplayTemplateState();
}

class _ImagePostDisplayTemplateState extends State<ImagePostDisplayTemplate> {
  String _ownerId;
  String _thisUserId;
  bool _isOwner = false;
  bool _isShared = false;
  int _numberOfComments;
  int _numberOfReactions;

  //when the post delete is clicked
  bool _postRemoved = false;

  List _likes = [];

  @override
  void initState() {
    _ownerId = widget.postContent["imagePost"]["postBy"]["_id"].toString();
    _thisUserId = PrimaryUserData.primaryUserData.userId.toString();
    _isOwner = _ownerId == _thisUserId;
    _isShared = widget.postContent["primary"].toString() != "true";
    _likes.addAll(widget.postContent["likes"]);
    _numberOfReactions = _likes.length;
    _numberOfComments = widget.postContent["noOfComments"];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(widget.postContent["_id"].toString()),
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(color: Theme.of(context).primaryColor))),
      child: GestureDetector(
        onTap: () {
          if (!widget.useAsPostFullDetailTemplate) {
            if (_isShared) {
              Get.to(
                  SpecificPostDisplayPageScreen(
                    postId: widget.postContent["imagePost"]["_id"],
                  ),
                  preventDuplicates: false);
            } else {
              Get.to(
                  SpecificPostDisplayPageScreen(
                      postId: widget.postContent["imagePost"]["_id"],
                      postContent: widget.postContent),
                  preventDuplicates: false);
            }
          }
        },
        onDoubleTap: () {
          reactionCountUpdater(_thisUserId);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //basic info of the post
            Container(
              height: 45.0,
              padding: _isShared
                  ? EdgeInsets.zero
                  : EdgeInsets.symmetric(vertical: 3.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //
                  //
                  //user profile pic
                  GestureDetector(
                    onDoubleTap: () {
                      reactionCountUpdater(_thisUserId);
                    },
                    onTap: () {
                      Get.to(
                          () => UserProfileScreen(
                                profileOwnerId: widget.postContent["imagePost"]
                                    ["postBy"]["_id"],
                              ),
                          preventDuplicates: false);
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
                                widget.postContent["imagePost"]["postBy"]
                                    ["profilePic"],
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
                                widget.postContent["imagePost"]["postBy"]
                                            ["name"]
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
                            TimeStampProvider.timeStampProvider(widget
                                .postContent["imagePost"]["createdAt"]
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
                                    postId:
                                        widget.postContent["_id"].toString(),
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
                              postDescription: widget.postContent["imagePost"]
                                      ["description"]
                                  .toString(),
                              editedDescriptionUpdater: (String description) {
                                updateEditedDescription(description);
                                
                              },
                              parentController: widget.parentController,
                               removePost: () {
                                      _removePost();
                                    },
                            )
                          : OtherUserActionsOnPost(
                              postUserId: widget.postContent["imagePost"]
                                      ["postBy"]["_id"]
                                  .toString(),
                              postId: widget.postContent["_id"].toString(),
                            )
                      : Container()
                ],
              ),
            ),
            //description and tags container
            widget.postContent["imagePost"]["description"] == null ||
                    widget.postContent["imagePost"]["description"] == ""
                ? Container()
                : Container(
                    width: screenWidth,
                    padding: EdgeInsets.only(
                        top: 3.0, bottom: 3.0, right: 2.0, left: 2.0),
                    alignment: Alignment.centerLeft,
                    child: PostDescriptionWidget(
                      tags: [],
                      mentions: [],
                      description: widget.postContent["imagePost"]
                          ["description"],
                      postType: "imagePost",
                      displayFullText: widget.useAsPostFullDetailTemplate,
                    ),
                  ),
            GestureDetector(
              onLongPress: () {
                if (!widget.useAsPostFullDetailTemplate) {
                  Get.to(
                      () => SpecificPostDisplayPageScreen(
                          postId: widget.postContent["imagePost"]["_id"],
                          postContent: widget.postContent),
                      preventDuplicates: false);
                }
              },
              child: _imageLayoutSelector(
                  widget.postContent["imagePost"]["postContent"],
                  widget.postContent["imagePost"]["templateType"]),
            ),
            //total reactions count
            _isShared
                ? Container()
                : Container(
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
                            margin: EdgeInsets.only(
                                top: 10.0, left: 8.0, right: 8.0),
                            child: Text("Be the first to like",
                                style: TextStyle(fontSize: 14.0)),
                          ),
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
                                  : Icon(EvilIcons.heart,
                                      size: 28.0,
                                      color: Theme.of(context).iconTheme.color),
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
            _isShared
                ? Container()
                : widget.postContent["comments"] == null
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
                          ),
          ],
        ),
      ),
    );
  }

  _imageLayoutSelector(List imagesData, String templateType) {
    if (imagesData.length == 1) {
      return SingleImageDisplayTemplate(
        imageData: imagesData[0],
        aspectRatio: 0.8,
      );
    } else {
      switch (templateType.toLowerCase()) {
        case "imagecarousel":
          return ImageCarouselDisplayTemplate(
            images: imagesData,
            aspectRatio: 0.8,
          );
          break;
        case "vertical":
          if (imagesData.length == 2) {
            return DoubleImageVerticalDisplayTemplate(
              images: imagesData,
            );
          } else {
            return MultiImageVerticalDisplayTemplate(
              images: imagesData,
            );
          }

          break;
        case "horizontal":
          if (imagesData.length == 2) {
            return DoubleImageHorizontalDisplayTemplate(
              images: imagesData,
            );
          } else {
            return MultiImageHorizontalDisplayTemplate(
              images: imagesData,
            );
          }

          break;
        default:
      }
    }
  }
 //remove post
  _removePost() {
    setState(() {
      _postRemoved = true;
    });
  }
  //edited description updater
  updateEditedDescription(String editedDescription) {
    widget.postContent["imagePost"]["description"] = editedDescription;
    print("description $editedDescription");
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
