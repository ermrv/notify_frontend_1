import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/CommentDisplayTemplate.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CommentsDisplayLayout extends StatelessWidget {
  final commentData;
  final GetxController controller;

  const CommentsDisplayLayout({
    Key key,
    @required this.commentData,
    this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ///main comment container starts here
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 5.0,vertical: 2.0),
      //   padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Column(
        children: [
          CommentDisplayTemplate(
            type: "comment",
            data: commentData,
            commentBoxWidth: screenWidth - 65.0,
            commentId: commentData["_id"].toString(),
          ),
          Container(
            margin: EdgeInsets.only(left: 30.0),
            child: Column(
              children: [
                for (var i in commentData["subComments"])
                  CommentDisplayTemplate(
                    type: "subComment",
                    data: i,
                    commentBoxWidth: screenWidth - 95.0,
                    commentId: commentData["_id"].toString(),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
