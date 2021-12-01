import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/controllers/CommentDisplayController.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/AddNewCommentTemplate.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/CommentsDisplayLayout.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentsDisplayScreen extends StatelessWidget {
  final String postId;
  final Function(int) commentCountUpdater;

  CommentsDisplayScreen(
      {Key key, @required this.postId, @required this.commentCountUpdater})
      : super(key: key);
  final commentsDisplayController = Get.put(CommentDisplayController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommentDisplayController>(
      initState: (state) {
        commentsDisplayController.postId = postId;
        commentsDisplayController.getComments();
        commentsDisplayController.commentCountUpdater = commentCountUpdater;
      },
      builder: (controller) => Scaffold(
       
        bottomSheet: Container(
          height: 50.0,
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: GestureDetector(
            onTap: () {
              Get.bottomSheet(AddNewCommentTemplate());
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
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
                  Expanded(child: Container(child: Text("Add a  Comment",style: TextStyle(fontSize: 15.0),)))
                ],
              ),
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
                          Container(
                            height: 50.0,
                          )
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
