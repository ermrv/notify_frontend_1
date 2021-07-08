import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/CommentsDisplayManagerModule/views/CommentsDisplayScreen.dart';
import 'package:MediaPlus/MODULES/UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ReadMoreTextWidget.dart';
import 'package:MediaPlus/MODULES/ContentDisplayTemplateMangerModule/views/VideoPostRelatedViews/InPostVideoPlayer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

///play a video only for 15 seconds
///
///on tap navigate  to [VideoPostFeedPlayerPageScreen] or [ShortVideoPlayerLayout]
///depending upon the type of the video
class VideoPostDisplayTemplate extends StatefulWidget {
  final postContent;
  const VideoPostDisplayTemplate({Key key, @required this.postContent})
      : super(key: key);

  @override
  _VideoPostDisplayTemplateState createState() =>
      _VideoPostDisplayTemplateState();
}

class _VideoPostDisplayTemplateState extends State<VideoPostDisplayTemplate> {
  List _likes;
  bool _isOwner = false;
  String _ownerId;
  String _thisUserId;

  int _numberOfComments = 0;
  int _numberOfReactions = 0;
  int _numberOfShares = 0;

  @override
  void initState() {
    _ownerId = widget.postContent["videoPost"]["postBy"]["_id"].toString();
    _thisUserId = PrimaryUserData.primaryUserData.userId.toString();
    _isOwner = _ownerId == _thisUserId;
    _likes = widget.postContent["likes"];
    _numberOfReactions = _likes.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //post details like user profile pic and name
          Container(
            height: 60.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey[300]),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: CachedNetworkImage(
                        imageUrl: ApiUrlsData.domain +
                            widget.postContent["videoPost"]["postBy"]
                                ["profilePic"],
                        fit: BoxFit.fill,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 2.0),
                        child: Row(
                          children: [
                            Text(
                              widget.postContent["videoPost"]["postBy"]["name"]
                                      .toString() +
                                  "  ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15.0),
                            ),
                            Text(
                              widget.postContent["videoPost"]["postBy"]
                                      ["userName"]
                                  .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Text(
                          '2 hrs ago',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12.0),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Container(
                  child: PopupMenuButton<TextButton>(
                    elevation: 0.0,
                    padding: EdgeInsets.all(2.0),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem<TextButton>(
                            child: TextButton(
                          onPressed: () {
                            print("okay");
                          },
                          child: Text('Block User'),
                        ))
                      ];
                    },
                  ),
                )
              ],
            ),
          ),
          //caption container
          widget.postContent["videoPost"]["description"] == null ||
                  widget.postContent["videoPost"]["description"] == ""
              ? Container()
              : Container(
                  width: screenWidth,
                  padding: EdgeInsets.only(
                      top: 3.0, bottom: 3.0, right: 2.0, left: 2.0),
                  alignment: Alignment.centerLeft,
                  child: ReadMoreText(
                    widget.postContent["description"].toString(),
                    style: TextStyle(fontSize: 15.0),
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    colorClickableText: Colors.blue,
                  )),

          InPostVideoPlayer(
            postContent: widget.postContent,
          ),

          Container(
            height: 50.0,
            width: screenWidth,
            padding: EdgeInsets.symmetric(horizontal: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    
                    children: [
                      IconButton(
                          icon: _likes.contains(_thisUserId,)
                              ? Icon(
                                  Octicons.heart,
                                  size: 24.0,
                                  color: Colors.red,
                                )
                              : Icon(
                                  EvilIcons.heart,
                                  size: 28.0,
                                  color: Colors.white,
                                ),
                          onPressed: () {
                            reactionCountUpdater(_thisUserId);
                          }),
                      Text(_numberOfReactions.toString())
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(EvilIcons.comment,size: 28.0,),
                          onPressed: () {
                            Get.to(() => CommentsDisplayScreen(
                                  postId: widget.postContent["_id"],
                                ));
                          }),
                      Text(_numberOfComments.toString() + " "),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      IconButton(icon: Icon(MaterialCommunityIcons.share), onPressed: () {}),
                      Text(" 1.1k")
                    ],
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  commentCountUpdater(int count) {
    setState(() {
      _numberOfComments = count;
    });
  }

  reactionCountUpdater(String userId) {
    if (_likes.contains(userId)) {
      _likes.remove(userId);
      setState(() {
        _numberOfReactions = _likes.length;
      });
    } else {
      _likes.add(userId);
      setState(() {
        _numberOfReactions = _likes.length;
      });
    }
  }
}
