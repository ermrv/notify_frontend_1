import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReplyToCommentTemplate extends StatefulWidget {
  final commentData;
  final String commentId;
  final controller;

  const ReplyToCommentTemplate(
      {Key key,
      @required this.commentId,
      @required this.controller,
      @required this.commentData})
      : super(key: key);

  @override
  State<ReplyToCommentTemplate> createState() => _ReplyToCommentTemplateState();
}

class _ReplyToCommentTemplateState extends State<ReplyToCommentTemplate> {
  bool _showSendButton = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5.0, right: 2.0, left: 2.0),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
          height:1.0,
          width: screenWidth,
          color: Theme.of(context).accentColor.withOpacity(0.5),
                  ),
          Container(
            padding: EdgeInsets.only(left: 8.0, top: 2.0, bottom: 5.0),
            child: Row(
              children: [
                Text("Replying to  @"),
                Text(widget.commentData["commentBy"]["name"].toString(),
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
                    height: 25.0,
                    width: 25.0,
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
                            child: TextFormField(
                              autofocus: true,
                              controller:
                                  widget.controller.subCommentEditingController,
                              onChanged: (value) {
                                print(value);

                                setState(() {
                                  _showSendButton = value.toString() != "";
                                });
                                print(_showSendButton);
                              },
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                  hintText: "Add a comment",
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none),
                            ),
                          ),
                        ),
                        _showSendButton
                            ? IconButton(
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  widget.controller.addSubComments(
                                      widget.commentId.toString(),
                                      widget.controller
                                          .subCommentEditingController.text);
                                })
                            : Container(),
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
