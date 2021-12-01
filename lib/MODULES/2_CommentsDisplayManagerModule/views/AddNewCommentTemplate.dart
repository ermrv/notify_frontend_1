import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/controllers/CommentDisplayController.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewCommentTemplate extends StatefulWidget {
 

  @override
  State<AddNewCommentTemplate> createState() => _AddNewCommentTemplateState();
}

class _AddNewCommentTemplateState extends State<AddNewCommentTemplate> {
  final controller = Get.find<CommentDisplayController>();
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
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 2.0, right: 2.0),
            child: Container(
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
                                  controller: controller.commentEditingController,
                              onChanged: (value) {
                                print(value);

                                setState(() {
                                  _showSendButton = value.toString() != "";
                                });
                              },
                              keyboardType: TextInputType.multiline,
                              textCapitalization: TextCapitalization.sentences,
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
                                  controller.addComment(controller
                                      .commentEditingController.text);
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
