import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/CommentsDisplayScreen.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ImagePostRelatedViews/ImageDisplayTemplates/DuobleImageHorizontalDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ImagePostRelatedViews/ImageDisplayTemplates/DuobleImageVerticalDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ImagePostRelatedViews/ImageDisplayTemplates/ImageCarouselDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ImagePostRelatedViews/ImageDisplayTemplates/MultiImageHorizontalDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ImagePostRelatedViews/ImageDisplayTemplates/MultiImageVerticalDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ImagePostRelatedViews/ImageDisplayTemplates/SingleImageDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/UserActionsOnPost/OtherUserActionsOnPost.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/UserActionsOnPost/PostOwnerActionsOnPost.dart';

import 'package:MediaPlus/SERVICES_AND_UTILS/ReadMoreTextWidget.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

///widget to dispaly the image posts, given [postContent]
class ImagePostDisplayTemplate extends StatefulWidget {
  final postContent;

  ImagePostDisplayTemplate({Key key, this.postContent}) : super(key: key);

  @override
  _ImagePostDisplayTemplateState createState() =>
      _ImagePostDisplayTemplateState();
}

class _ImagePostDisplayTemplateState extends State<ImagePostDisplayTemplate> {
  String _ownerId;
  String _thisUserId;
  bool _isOwner = false;

  int _numberOfComments = 0;
  int _numberOfReactions = 0;

  List _likes = [];

  @override
  void initState() {
    _ownerId = widget.postContent["imagePost"]["postBy"]["_id"].toString();
    _thisUserId = PrimaryUserData.primaryUserData.userId.toString();
    _isOwner = _ownerId == _thisUserId;

    _likes = widget.postContent["likes"];
    _numberOfReactions = _likes.length;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(color: Theme.of(context).primaryColor))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //basic info of the post
          Container(
            height: 60.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //
                //
                //user profile pic
                Container(
                  padding: EdgeInsets.all(1.0),
                  height: 35.0,
                  width: 35.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.deepOrange[900]),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: CachedNetworkImage(
                        imageUrl: ApiUrlsData.domain +
                            widget.postContent["imagePost"]["postBy"]
                                ["profilePic"],
                        fit: BoxFit.fill,
                      )),
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
                              widget.postContent["imagePost"]["postBy"]["name"]
                                      .toString() +
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
                          'location',
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
                _isOwner
                    ? PostOwnerActionsOnPost(
                        postId: widget.postContent["_id"].toString(),
                        postDescription: widget.postContent["imagePost"]
                                ["description"]
                            .toString(),
                        editedDescriptionUpdater: (String description) {
                          updateEditedDescription(description);
                        },
                      )
                    : OtherUserActionsOnPost(
                        postUserId: widget.postContent["imagePost"]["postBy"]
                                ["_id"]
                            .toString(),
                        postId: widget.postContent["_id"].toString(),
                      )
              ],
            ),
          ),

          GestureDetector(
            onDoubleTap: () {
              reactionCountUpdater(_thisUserId);
            },
            child: _imageLayoutSelector(
                widget.postContent["imagePost"]["postContent"],
                widget.postContent["imagePost"]["templateType"]),
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
                  child: ReadMoreText(
                    widget.postContent["imagePost"]["description"]
                        .toString()
                        .capitalizeFirst,
                    style: TextStyle(fontSize: 15.0),
                    trimLines: 2,
                    trimCollapsedText: "...more",
                    trimExpandedText: "  less",
                    trimMode: TrimMode.Line,
                    colorClickableText: Colors.blue,
                  )),
          Container(
            height: 50.0,
            width: screenWidth,
            padding: EdgeInsets.symmetric(horizontal: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
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
                      Text(_numberOfReactions.toString())
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            EvilIcons.comment,
                            size: 28.0,
                          ),
                          onPressed: () {
                            Get.to(() => CommentsDisplayScreen(
                                  postId: widget.postContent["_id"],
                                ));
                          }),
                      Text(_numberOfComments.toString() + " "),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(MaterialCommunityIcons.share),
                          onPressed: () {}),
                      Text(" 1.1k")
                    ],
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
        ],
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

  //edited description updater
  updateEditedDescription(String editedDescription) {
    widget.postContent["imagePost"]["description"] = editedDescription;
    if (this.mounted) {
      setState(() {});
    }
  }

  commentCountUpdater(int count) {
    setState(() {
      _numberOfReactions = count;
    });
  }

  //reaction count updater
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
