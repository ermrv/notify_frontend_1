
import 'package:MediaPlus/MODULES/CommentsDisplayManagerModule/controllers/CommentDisplayController.dart';
import 'package:MediaPlus/MODULES/CommentsDisplayManagerModule/views/CommentsDisplayLayout.dart';
import 'package:MediaPlus/MODULES/UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentsDisplayScreen extends StatelessWidget {
  final String postId;

  CommentsDisplayScreen({Key key, @required this.postId}) : super(key: key);
  final commentsDisplayController = Get.put(CommentDisplayController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommentDisplayController>(
      initState: (state) {
        commentsDisplayController.postId = postId;
        commentsDisplayController.getComments();
      },
      builder: (controller) => Scaffold(
        
        bottomSheet: Container(
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
                      child: CachedNetworkImage(
                        imageUrl: PrimaryUserData.primaryUserData.profilePic,
                        fit: BoxFit.fill,
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
                            controller: controller.commentEditingController,
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
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            controller.addComment(
                                controller.commentEditingController.text);
                          })
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
        appBar: AppBar(
          elevation: 0.5,
          title: Text(
            "Comments",
            style: TextStyle(),
          ),
        ),
        body: controller.isCommentsLoaded
            ? controller.comments.length == 0
                ? Center(
                    child: Text("Be the First to Comment"),
                  )
                : RefreshIndicator(
                    onRefresh: () {
                      return controller.getComments();
                    },
                    child: ListView(
                      children: [
                        for (var i in controller.comments)
                          CommentsDisplayLayout(
                            commentData: i,
                          ),
                       
                      ],
                    ),
                  )
            : Container(
                child: LinearProgressIndicator(),
              ),
      ),
    );
  }
}
