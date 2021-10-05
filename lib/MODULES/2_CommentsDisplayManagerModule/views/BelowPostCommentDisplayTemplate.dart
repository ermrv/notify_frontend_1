import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/CommentsDisplayScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BelowPostCommentDisplayTemplate extends StatelessWidget {
  final commentData;
  final postId;
  final Function(int) commentCountUpdater;

  const BelowPostCommentDisplayTemplate(
      {Key key,
      @required this.commentData,
      @required this.postId,
      @required this.commentCountUpdater})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //profile pic
                Container(
                  child: CircleAvatar(
                    radius: 14.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: CachedNetworkImage(
                          imageUrl: ApiUrlsData.domain +
                              commentData["commentBy"]["profilePic"]
                                  .toString()),
                    ),
                  ),
                ),
                //name and comment container
                Container(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 2.0),
                        child: Text(
                          commentData["commentBy"]["name"].toString(),
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        child: Text(
                          commentData["comment"].toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 1.0,
                  color: Theme.of(context).accentColor.withOpacity(0.5),
                ),
              ),
              Container(
                child: Text(
                  "Show all comments",
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
