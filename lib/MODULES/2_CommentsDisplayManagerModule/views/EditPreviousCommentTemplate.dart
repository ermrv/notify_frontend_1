import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/controllers/CommentDisplayController.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPreviousCommentTemplate extends StatefulWidget {
  final commentData;
  final String commentId;
  final String initialComment;
  final CommentDisplayController controller;

  const EditPreviousCommentTemplate(
      {Key key,
      @required this.commentData,
      @required this.commentId,
      @required this.controller,
      @required this.initialComment})
      : super(key: key);

  @override
  _EditPreviousCommentTemplateState createState() =>
      _EditPreviousCommentTemplateState();
}

class _EditPreviousCommentTemplateState
    extends State<EditPreviousCommentTemplate> {
  bool _showSendButton = false;
  double _bottomSheetHeight = 55.0;
  @override
  void initState() {
    _showSendButton = widget.initialComment != null;
    _bottomSheetHeight = 55.0 +
        (widget.controller.getNumberOfLines(widget.initialComment).toDouble()) *
            18;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      height: _bottomSheetHeight,
      padding: EdgeInsets.only(left: 2.0, right: 2.0),
      child: Container(
        
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
        child: Column(
          children: [
            Container(
            height:1.0,
            width: screenWidth,
            alignment: Alignment.center,
            color: Theme.of(context).accentColor.withOpacity(0.5),
                    ),
            Row(
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
                            controller: widget.controller.editCommentController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: "Add Comment"),
                            onChanged: (value) {
                              _bottomSheetHeight = 55.0 +
                                  (widget.controller
                                          .getNumberOfLines(value.toString())
                                          .toDouble()) *
                                      18;
                              setState(() {
                                _showSendButton = value.toString() != "";
                              });
                            },
                          ),
                        ),
                      ),
                      _showSendButton
                          ? IconButton(
                              icon: Icon(
                                Icons.send,
                              ),
                              onPressed: () {
                                widget.controller.editComment(widget.commentId);
                              })
                          : Container()
                    ],
                  ),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
