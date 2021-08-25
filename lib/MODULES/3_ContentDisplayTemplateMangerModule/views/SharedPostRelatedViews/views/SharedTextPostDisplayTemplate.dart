import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/CommentsDisplayScreen.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/TextPostRelatedViews/TextPostDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/UserActionsOnPost/OtherUserActionsOnPost.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/UserActionsOnPost/PostOwnerActionsOnPost.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ReadMoreTextWidget.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/TimeStampProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class SharedTextPostDisplayTemplate extends StatefulWidget {
  final postContent;

  const SharedTextPostDisplayTemplate({Key key, @required this.postContent})
      : super(key: key);

  @override
  _SharedTextPostDisplayTemplateState createState() =>
      _SharedTextPostDisplayTemplateState();
}

class _SharedTextPostDisplayTemplateState
    extends State<SharedTextPostDisplayTemplate> {
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
                            widget.postContent["postBy"]["profilePic"],
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
                _isOwner
                    ? PostOwnerActionsOnPost(
                        postId: widget.postContent["_id"].toString(),
                        postDescription:
                            widget.postContent["sharedDiscription"].toString(),
                        editedDescriptionUpdater: (String description) {
                          updateEditedDescription(description);
                        },
                      )
                    : OtherUserActionsOnPost(
                        postUserId:
                            widget.postContent["postBy"]["_id"].toString(),
                        postId: widget.postContent["_id"].toString(),
                      )
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
                borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                      width: 0.5,
                      color: Theme.of(context).accentColor.withOpacity(0.5))),
              child: TextPostDisplayTemplate(
                postContent: widget.postContent,
              )),
          //like comment and share button container
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

  //edited description updater
  updateEditedDescription(String editedDescription) {
    widget.postContent["sharedDescription"] = editedDescription;
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
