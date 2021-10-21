import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/CommentsDisplayScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BelowPostCommentDisplayTemplate extends StatelessWidget {
  final int commentCount;
  final commentData;
  final postId;
  final Function(int) commentCountUpdater;

  const BelowPostCommentDisplayTemplate(
      {Key key,
      @required this.commentData,
      @required this.postId,
      @required this.commentCountUpdater,
      @required this.commentCount})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => CommentsDisplayScreen(
            postId: postId,
            commentCountUpdater: (int count) {
              commentCountUpdater.call(count);
            },
          ),
        );
      },
      child: Container(
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //profile pic
                  Container(
                    height: 15.0,
                    width: 15.0,
                    decoration: BoxDecoration(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: CachedNetworkImage(
                        imageUrl: ApiUrlsData.domain +
                            commentData["commentBy"]["profilePic"].toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  //name and comment container
                  Container(
                    padding: EdgeInsets.only(left: 5.0),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: commentData["commentBy"]["name"].toString(),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: ": " + commentData["comment"].toString())
                    ])),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 5.0, bottom: 10.0, right: 8.0, left: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Container(
                    child: commentCount == 1
                        ? Text(
                            " Show all ${commentCount.toString()} comment",
                            style: TextStyle(fontSize: 12.0),
                          )
                        : Text(
                            " Show all ${commentCount.toString()} comments",
                            style: TextStyle(fontSize: 12.0),
                          ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
