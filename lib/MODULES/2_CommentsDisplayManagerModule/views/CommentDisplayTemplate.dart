import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/controllers/CommentDisplayController.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/UserProfileScreen.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/TimeStampProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentDisplayTemplate extends StatefulWidget {
  final data;
  final String commentId;
  final double commentBoxWidth;
  final String type;

  CommentDisplayTemplate({
    Key key,
    @required this.data,
    @required this.commentBoxWidth,
    @required this.commentId,
    @required this.type,
  }) : super(key: key);

  @override
  State<CommentDisplayTemplate> createState() => _CommentDisplayTemplateState();
}

class _CommentDisplayTemplateState extends State<CommentDisplayTemplate> {
  final controller = Get.find<CommentDisplayController>();
  bool showSendButton=false;

  bool commentOfPrimaryUser;
  List<String> commentLikes;
  @override
  void initState() {
    commentOfPrimaryUser = widget.data["commentBy"]["_id"].toString() ==
            PrimaryUserData.primaryUserData.userId
        ? true
        : false;
    super.initState();
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
                    child: Text(
                      widget.data["comment"].toString(),
                      style: TextStyle(fontSize: 16.0),
                    )),
                //comment details container
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 10.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _commentReactionUpdater();
                              },
                              child: Container(
                                  padding: EdgeInsets.only(
                                      top: 2.0,
                                      bottom: 2.0,
                                      right: 15.0,
                                      left: 8.0),
                                  child: Icon(
                                    Icons.favorite_border,
                                    size: 18.0,
                                  )),
                            ),
                            Text("23",
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
                          Get.bottomSheet(
                            Container(
                              padding: EdgeInsets.only(
                                  top: 5.0, right: 2.0, left: 2.0),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 8.0, top: 2.0, bottom: 5.0),
                                    child: Row(
                                      children: [
                                        Text("Replying to  @"),
                                        Text(
                                            widget.data["commentBy"]["name"]
                                                .toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.only(left: 2.0, right: 2.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        border: Border.all(),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(right: 8.0),
                                            height: 25.0,
                                            width: 25.0,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                                child: Obx(
                                                  () => CachedNetworkImage(
                                                    imageUrl: PrimaryUserData
                                                        .primaryUserData
                                                        .profilePic
                                                        .value,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )),
                                          ),
                                          Expanded(
                                              child: Container(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: TextFormField(
                                                      autofocus: true,
                                                      controller: controller
                                                          .subCommentEditingController,
                                                      onChanged: (value) {
                                                        print(value);

                                                        setState(() {
                                                          showSendButton =
                                                              value != "";
                                                        });
                                                        print(showSendButton);
                                                      },
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      maxLines: null,
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              "Add a comment",
                                                          border:
                                                              InputBorder.none,
                                                          focusedBorder:
                                                              InputBorder.none),
                                                    ),
                                                  ),
                                                ),
                                               IconButton(
                                                    icon: Icon(
                                                      Icons.send,
                                                      color: Colors.blue,
                                                    ),
                                                    onPressed: () {
                                                      controller.addSubComments(
                                                          widget.commentId
                                                              .toString(),
                                                          controller
                                                              .subCommentEditingController
                                                              .text);
                                                    }),
                                              ],
                                            ),
                                          ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
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
  _commentReactionUpdater() async {}

  _commentEditor(String commentId, String initialComment) {
    controller.editCommentController.text = initialComment;
    Get.bottomSheet(
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 2.0, right: 2.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(),
          ),
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 8.0),
                height: 35.0,
                width: 35.0,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Obx(
                      () => CachedNetworkImage(
                        imageUrl:
                            PrimaryUserData.primaryUserData.profilePic.value,
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              Expanded(
                  child: Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          autofocus: true,
                          controller: controller.editCommentController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration.collapsed(
                              border: InputBorder.none,
                              hintText: "Add Comment"),
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.send,
                        ),
                        onPressed: () {
                          controller.editComment(commentId);
                        })
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  _subCommentEditor(
      String commentId, String subCommentId, String initialSubComment) {
    controller.editSubCommentController.text = initialSubComment;
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(top: 5.0, right: 2.0, left: 2.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(left: 8.0, top: 2.0, bottom: 5.0),
              child: Row(
                children: [
                  Text("Replying to  @"),
                  Text(widget.data["commentBy"]["name"].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ))
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 2.0, right: 2.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 5.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 8.0),
                      height: 35.0,
                      width: 35.0,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Obx(
                            () => CachedNetworkImage(
                              imageUrl: PrimaryUserData
                                  .primaryUserData.profilePic.value,
                              fit: BoxFit.cover,
                            ),
                          )),
                    ),
                    Expanded(
                        child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 40.0,
                              child: TextFormField(
                                autofocus: true,
                                controller: controller.editSubCommentController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                onChanged: (value) {
                                  controller.update();
                                },
                                decoration: InputDecoration.collapsed(
                                  hintText: "Add a comment",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          controller.editSubCommentController.text == null
                              ? Container()
                              : IconButton(
                                  icon: Icon(
                                    Icons.send,
                                  ),
                                  onPressed: () {
                                    controller.editSubComment(
                                        commentId, subCommentId);
                                  })
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
