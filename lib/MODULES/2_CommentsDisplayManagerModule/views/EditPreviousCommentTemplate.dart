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

  const EditPreviousCommentTemplate(
      {Key key,
      @required this.commentData,
      @required this.commentId,
      @required this.initialComment})
      : super(key: key);

  @override
  _EditPreviousCommentTemplateState createState() =>
      _EditPreviousCommentTemplateState();
}

class _EditPreviousCommentTemplateState
    extends State<EditPreviousCommentTemplate> {
  final controller = Get.find<CommentDisplayController>();
  bool _showSendButton = false;
  @override
  void initState() {
    _showSendButton = widget.initialComment != null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.only(left: 2.0, right: 2.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
        child: Column(
          children: [
            Container(
              height: 1.0,
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
                            controller: controller.editCommentController,
                            keyboardType: TextInputType.multiline,
                            textCapitalization: TextCapitalization.sentences,
                            maxLines: null,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: "Add Comment"),
                            onChanged: (value) {
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
                                controller.editComment(widget.commentId);
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
