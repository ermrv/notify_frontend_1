import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/CommentsDisplayScreen.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ImagePostRelatedViews/FullImagePostDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/UserActionsOnPost/OtherUserActionsOnPost.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/UserActionsOnPost/PostOwnerActionsOnPost.dart';
import 'package:MediaPlus/MODULES/4_ContestingModule/ContestHostingModule/views/ContestParticipantsPostScreen.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ReadMoreTextWidget.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

///template for post of type contest
class ContestPostDisplayTemplate extends StatefulWidget {
  final postContent;
  final controller;

  const ContestPostDisplayTemplate({Key key, @required this.postContent, this.controller})
      : super(key: key);
  @override
  _ContestPostDisplayTemplateState createState() =>
      _ContestPostDisplayTemplateState();
}

class _ContestPostDisplayTemplateState
    extends State<ContestPostDisplayTemplate> {
  List _likes;
  bool _isOwner = false;
  String _ownerId;
  String _thisUserId;

  int _numberOfComments = 0;
  int _numberOfReactions = 0;

  @override
  void initState() {
    _ownerId = widget.postContent["contestPost"]["contestBy"]["_id"].toString();
    _thisUserId = PrimaryUserData.primaryUserData.userId.toString();
    _isOwner = _ownerId == _thisUserId;
    _likes = widget.postContent["likes"];
    _numberOfReactions = _likes.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.0, right: 5.0, left: 5.0),
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(color: Theme.of(context).primaryColor))),
      child: Column(
          //post details like user profile pic and name
          children: [
            Container(
              height: 60.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[300]),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: CachedNetworkImage(
                          imageUrl: ApiUrlsData.domain +
                              widget.postContent["contestPost"]["contestBy"]
                                  ["profilePic"],
                          fit: BoxFit.fill,
                        )),
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
                                widget.postContent["contestPost"]["contestBy"]
                                            ["name"]
                                        .toString() +
                                    "  ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0),
                              ),
                              Text(
                                widget.postContent["contestPost"]["contestBy"]
                                        ["userName"]
                                    .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1.0, horizontal: 5.0),
                              decoration: BoxDecoration(
                                  color: Colors.red[900],
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Text(
                                "CONTEST",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                child: DateTime.parse(
                                            widget.postContent["contestPost"]
                                                ["endsOn"])
                                        .isAfter(DateTime.now())
                                    ? Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Contest is Live ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13.0),
                                            ),
                                            // SpinKitThreeBounce(
                                            //   color: Colors.green,
                                            //   size: 10.0,
                                            // )
                                          ],
                                        ),
                                      )
                                    : Container(
                                        child: Text(
                                          "Contest Ended",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.0),
                                        ),
                                      )),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  _isOwner
                      ? TextButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.resolveWith(
                                  (states) => EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 15.0))),
                          child: Text(
                            "Promote",
                          ),
                          onPressed: () {
                            print("object");
                          })
                      : Container(),
                  //actions on post
                  _isOwner
                      ? PostOwnerActionsOnPost(
                          postId: widget.postContent["_id"].toString(),
                          postDescription: widget.postContent["contestPost"]
                                  ["description"]
                              .toString(),
                          editedDescriptionUpdater: (String description) {
                            updateEditedDescription(description);
                            
                          },
                          parentController:widget.controller,
                        )
                      : OtherUserActionsOnPost(
                          postUserId: widget.postContent["contestPost"]
                                  ["postBy"]["_id"]
                              .toString(),
                          postId: widget.postContent["_id"].toString(),
                          
                        )
                ],
              ),
            ),
            // Container(
            //     width: screenWidth,
            //     padding: EdgeInsets.only(top: 3.0, right: 2.0, left: 2.0),
            //     alignment: Alignment.centerLeft,
            //     child: Text(
            //       widget.postContent["contestPost"]["contestName"].toString(),
            //       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            //     )),
            Container(
                width: screenWidth,
                padding: EdgeInsets.only(right: 2.0, left: 2.0),
                alignment: Alignment.centerLeft,
                child: ReadMoreText(
                  widget.postContent["contestPost"]["description"].toString() +
                      "\n" +
                      widget.postContent["contestPost"]["contestRules"][0]
                          .toString(),
                  trimLines: 4,
                  trimMode: TrimMode.Line,
                  colorClickableText: Colors.blue,
                )),
            GestureDetector(
              onTap: () {
                Get.to(() => FullScreenImagePostDisplay(
                      imagesData: [
                        {
                          "path": widget.postContent["contestPost"]["poster"]
                              .toString()
                        }
                      ],
                      initialPage: 0,
                    ));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 0.0),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: CachedNetworkImage(
                    imageUrl: ApiUrlsData.domain +
                        widget.postContent["contestPost"]["poster"].toString(),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Container(
              height: 60.0,
              child: Row(
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
                                    commentCountUpdater: (int count) {
                                      commentCountUpdater(count);
                                    },
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
                  Container(
                    margin: EdgeInsets.only(right: 8.0),
                    child: _isOwner
                        ? TextButton(
                            onPressed: () {
                              Get.to(() => ContestParticipantsPostScreen(
                                  contestId: widget.postContent["contestPost"]
                                      ["_id"],
                                  contestName: widget.postContent["contestPost"]
                                      ["contestName"]));
                            },
                            child: Text("Participants"))
                        : TextButton(
                            onPressed: () {}, child: Text("Participate")),
                  )
                ],
              ),
            )
          ]),
    );
  }

  //edited description updater
  updateEditedDescription(String editedDescription) {
    widget.postContent["contestPost"]["description"] = editedDescription;
    if (this.mounted) {
      setState(() {});
    }
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
