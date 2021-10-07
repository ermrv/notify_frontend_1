import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/controllers/CommentDisplayController.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/TimeStampProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentDisplayTemplate extends StatelessWidget {
  final data;
  final String commentId;
  final double commentBoxWidth;
  final String type;
  final controller = Get.find<CommentDisplayController>();
  bool commentOfPrimaryUser;

  CommentDisplayTemplate({
    Key key,
    @required this.data,
    @required this.commentBoxWidth,
    @required this.commentId,
    @required this.type,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    commentOfPrimaryUser = data["commentBy"]["_id"].toString() ==
            PrimaryUserData.primaryUserData.userId
        ? true
        : false;
    return //this contaner contains the user profile pic and the main comment
        Container(
      margin: EdgeInsets.only(bottom: 20.0, left: 5.0, top: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //user profile pic continer
          Container(
            margin: EdgeInsets.only(top: 5.0),
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: CachedNetworkImage(
                  imageUrl:
                      ApiUrlsData.domain + data["commentBy"]["profilePic"],
                  fit: BoxFit.fill,
                )),
          ),
          //user name and main comment container
          Container(
            width: commentBoxWidth,
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
                        data["commentBy"]["name"].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: Text(
                        TimeStampProvider.timeStampProvider(data["createdAt"]),
                        style: TextStyle(fontSize: 13.0),
                      ),
                    ),
                    Expanded(child: Container()),
                    Container(
                      child: PopupMenuButton(
                        ///handling of comments
                        onSelected: (value) {
                          if (type == "comment") {
                            switch (value) {
                              case "Delete Comment":
                                controller.removeComment(commentId);

                                break;
                              case "Edit Comment":
                                _commentEditor(commentId, data["comment"]);
                                break;
                              case "Report Comment":
                                print("report");
                                break;

                              default:
                            }
                          } else if (type == "subComment") {
                            switch (value) {
                              case "Delete Comment":
                                controller.removeSubComment(
                                    commentId, data["_id"]);

                                break;
                              case "Edit Comment":
                                _subCommentEditor(
                                    commentId, data["_id"], data["comment"]);
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
                    width: commentBoxWidth,
                    child: Text(
                      data["comment"].toString(),
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
                                print("liked");
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
                                            data["commentBy"]["name"]
                                                .toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 50.0,
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
                                            height: 35.0,
                                            width: 35.0,
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
                                                    height: 40.0,
                                                    child: TextFormField(
                                                      autofocus: true,
                                                      controller: controller
                                                          .subCommentEditingController,
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
                                                    ),
                                                    onPressed: () {
                                                      controller.addSubComments(
                                                          commentId.toString(),
                                                          controller
                                                              .subCommentEditingController
                                                              .text);
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

  _commentEditor(String commentId, String initialComment) {
    controller.editCommentController.text = initialComment;
    Get.bottomSheet(
      Container(
        alignment: Alignment.center,
        height: 50.0,
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
                        height: 40.0,
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
                  Text(data["commentBy"]["name"].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ))
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 50.0,
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
                                decoration: InputDecoration.collapsed(
                                  hintText: "Add a comment",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
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
