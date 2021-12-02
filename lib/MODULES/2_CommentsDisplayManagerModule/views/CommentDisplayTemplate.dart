import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/controllers/CommentDisplayController.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/EditPreviousCommentTemplate.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/EditPreviousSubCommentTemplate.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/ReplyToCommentTemplate.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/UserProfileScreen.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/CommentTextWidget.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/TimeStampProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentDisplayTemplate extends StatefulWidget {
  final data;
  final String commentId;
  final double commentBoxWidth;
  final String type;

  ///in case the template is used for subcomment
  final String parentCommentId;

  CommentDisplayTemplate({
    Key key,
    @required this.data,
    @required this.commentBoxWidth,
    @required this.commentId,
    @required this.type,
    @required this.parentCommentId,
  }) : super(key: key);

  @override
  State<CommentDisplayTemplate> createState() => _CommentDisplayTemplateState();
}

class _CommentDisplayTemplateState extends State<CommentDisplayTemplate> {
  final controller = Get.find<CommentDisplayController>();
  bool showSendButton = false;

  bool commentOfPrimaryUser;
  List _likes = [];
  String _thisUserId;
  int _numberOfReactions;
  @override
  void initState() {
    commentOfPrimaryUser = widget.data["commentBy"]["_id"].toString() ==
            PrimaryUserData.primaryUserData.userId
        ? true
        : false;
    _likes.addAll(widget.data["likes"]);
    _thisUserId = PrimaryUserData.primaryUserData.userId;
    super.initState();
    _numberOfReactions = _likes.length;
  }

  @override
  Widget build(BuildContext context) {
    return //this contaner contains the user profile pic and the main comment
        Container(
      margin: EdgeInsets.only(bottom: 10.0, left: 5.0, top: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //user profile pic continer
          GestureDetector(
            onTap: () {
              Get.to(() => UserProfileScreen(
                  profileOwnerId: widget.data["commentBy"]["_id"]));
            },
            child: Container(
              margin: EdgeInsets.only(top: 5.0),
              height: 25.0,
              width: 25.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: CachedNetworkImage(
                    imageUrl: ApiUrlsData.domain +
                        widget.data["commentBy"]["profilePic"],
                    fit: BoxFit.fill,
                  )),
            ),
          ),
          //user name and main comment container
          Container(
            width: widget.commentBoxWidth,
            padding: EdgeInsets.only(right: 5.0, left: 5.0, top: 5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //user name container
                Row(
                  children: [
                    Container(
                      child: Text(
                        widget.data["commentBy"]["name"].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: Text(
                        TimeStampProvider.timeStampProvider(
                            widget.data["createdAt"]),
                        style: TextStyle(fontSize: 13.0),
                      ),
                    ),
                    Expanded(child: Container()),
                    Container(
                      child: PopupMenuButton(
                        iconSize: 8.0,

                        ///handling of comments
                        onSelected: (value) {
                          if (widget.type == "comment") {
                            switch (value) {
                              case "Delete Comment":
                                controller.removeComment(widget.commentId);

                                break;
                              case "Edit Comment":
                                _commentEditor(
                                    widget.commentId, widget.data["comment"]);
                                break;
                              case "Report Comment":
                                print("report");
                                break;

                              default:
                            }
                          } else if (widget.type == "subComment") {
                            switch (value) {
                              case "Delete Comment":
                                controller.removeSubComment(
                                    widget.commentId, widget.data["_id"]);

                                break;
                              case "Edit Comment":
                                _subCommentEditor(widget.commentId,
                                    widget.data["_id"], widget.data["comment"]);
                                break;
                              case "Report Comment":
                                print("report");
                                break;
                              default:
                            }
                          }
                        },
                        elevation: 2.0,
                        padding: EdgeInsets.all(2.0),
                        child: Container(
                          child: Icon(Icons.more_vert),
                        ),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              value: "Delete Comment",
                              height: commentOfPrimaryUser ? 50.0 : 0.0,
                              child: commentOfPrimaryUser
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 6.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Text("Delete Comment"),
                                    )
                                  : Container(),
                            ),
                            PopupMenuItem(
                              value: "Edit Comment",
                              height: commentOfPrimaryUser ? 50.0 : 0.0,
                              child: commentOfPrimaryUser
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Text("Edit Comment"),
                                    )
                                  : Container(),
                            ),
                            PopupMenuItem(
                              value: "Report Comment",
                              height: !commentOfPrimaryUser ? 50.0 : 0.0,
                              child: !commentOfPrimaryUser
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Text("Report Comment"),
                                    )
                                  : Container(),
                            ),
                          ];
                        },
                      ),
                    )
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(top: 5.0),
                    width: widget.commentBoxWidth,
                    child: CommentTextWidget(
                      tags: [],
                      mentions: [],
                      commentText: widget.data["comment"].toString(),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 5.0),
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  _commentReactionUpdater(_thisUserId);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 2.0,
                                      bottom: 2.0,
                                      right: 15.0,
                                      left: 8.0),
                                  child: _likes.contains(_thisUserId)
                                      ? Icon(
                                          Icons.favorite,
                                          size: 20.0,
                                          color: Colors.red,
                                        )
                                      : Icon(
                                          Icons.favorite_border,
                                          size: 20.0,
                                          color:
                                              Theme.of(context).iconTheme.color,
                                        ),
                                )),
                            Text("$_numberOfReactions",
                                style: TextStyle(fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      Container(
                          height: 10.0,
                          width: 2.0,
                          margin: EdgeInsets.symmetric(horizontal: 5.0)),
                      GestureDetector(
                        onTap: () {
                          _replyToComment(widget.commentId, controller);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 2.0),
                          child: Text("Reply",
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  ///comment reaction updater
  _commentReactionUpdater(String userId) async {
    //update  likes if subcomment
    if (widget.type == "subComment") {
      if (_likes.contains(userId)) {
        _likes.remove(userId);
        setState(() {
          _numberOfReactions = _likes.length;
        });
        var response = await ApiServices.postWithAuth(
            ApiUrlsData.likeSubComment,
            {
              "commentId": widget.parentCommentId,
              "subCommentId": widget.commentId,
              "like": false
            },
            userToken);
        if (response == "error") {
          Get.snackbar("Somethings wrong", "Your reaction is not updated");
        }
      } else {
        _likes.add(userId);
        setState(() {
          _numberOfReactions = _likes.length;
        });
        var response = await ApiServices.postWithAuth(
            ApiUrlsData.likeSubComment,
            {
              "commentId": widget.parentCommentId,
              "subCommentId": widget.commentId,
              "like": true
            },
            userToken);
        if (response == "error") {
          Get.snackbar("Somethings wrong", "Your reaction is not updated");
        }
      }
    }
    //update likes if comment
    else {
      if (_likes.contains(userId)) {
        _likes.remove(userId);
        setState(() {
          _numberOfReactions = _likes.length;
        });
        var response = await ApiServices.postWithAuth(ApiUrlsData.likeComment,
            {"commentId": widget.commentId, "like": false}, userToken);
        if (response == "error") {
          Get.snackbar("Somethings wrong", "Your reaction is not updated");
        }
      } else {
        _likes.add(userId);
        setState(() {
          _numberOfReactions = _likes.length;
        });
        var response = await ApiServices.postWithAuth(ApiUrlsData.likeComment,
            {"commentId": widget.commentId, "like": true}, userToken);
        if (response == "error") {
          Get.snackbar("Somethings wrong", "Your reaction is not updated");
        }
      }
    }
  }

  ///.......................replay to a comment.......................
  _replyToComment(String commentId, CommentDisplayController controller) {
    Get.bottomSheet(
        ReplyToCommentTemplate(commentId: commentId, commentData: widget.data));
  }

  ///......................................edit comment......................................
  _commentEditor(String commentId, String initialComment) {
    controller.editCommentController.text = initialComment;
    Get.bottomSheet(
      EditPreviousCommentTemplate(
          commentData: widget.data,
          commentId: commentId,
          initialComment: initialComment),
    );
  }

  ///.........edit sub comment...............
  _subCommentEditor(
      String commentId, String subCommentId, String initialSubComment) {
    controller.editSubCommentController.text = initialSubComment;
    Get.bottomSheet(EditPreviousSubCommentTemplate(
        subCommentData: widget.data,
        subCommentId: subCommentId,
        commentId: commentId,
        initialSubComment: initialSubComment));
  }
}
