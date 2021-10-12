import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/controllers/CommentDisplayController.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPreviousSubCommentTemplate extends StatefulWidget {
  final subCommentData;
  final String subCommentId;
  final String commentId;
  final String initialSubComment;
  final CommentDisplayController controller;

  const EditPreviousSubCommentTemplate(
      {Key key,
      @required this.subCommentData,
      @required this.subCommentId,
      @required this.commentId,
      @required this.initialSubComment,
      @required this.controller})
      : super(key: key);

  @override
  _EditPreviousSubCommentTemplateState createState() =>
      _EditPreviousSubCommentTemplateState();
}

class _EditPreviousSubCommentTemplateState
    extends State<EditPreviousSubCommentTemplate> {
  bool _showSendButton = false;
  double _bottomSheetHeight = 80.0;
  @override
  void initState() {
    _showSendButton = widget.initialSubComment != null;
    _bottomSheetHeight = 80.0 +
        (widget.controller
                .getNumberOfLines(widget.initialSubComment)
                .toDouble()) *
            18;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
     
      height: _bottomSheetHeight,
      padding: EdgeInsets.only(top: 5.0, right: 2.0, left: 2.0),
      decoration: BoxDecoration(
         color: Theme.of(context).scaffoldBackgroundColor,
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
                Text(widget.subCommentData["commentBy"]["name"].toString(),
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
                            child: TextFormField(
                              autofocus: true,
                              controller:
                                  widget.controller.editSubCommentController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              onChanged: (value) {
                                _bottomSheetHeight = 80.0 +
                                    (widget.controller
                                            .getNumberOfLines(value.toString())
                                            .toDouble()) *
                                        18;
                                setState(() {
                                  _showSendButton = value.toString() != "";
                                });
                                // widget.controller.update();
                              },
                              decoration: InputDecoration(
                                hintText: "Add a comment",
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                        _showSendButton
                            ? IconButton(
                                icon: Icon(
                                  Icons.send,
                                ),
                                onPressed: () {
                                  widget.controller.editSubComment(
                                      widget.commentId, widget.subCommentId);
                                })
                            : Container()
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
