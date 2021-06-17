import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/ContentDisplayTemplateMangerModule/views/ImagePostRelatedViews/FullImagePostDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/ContestingModule/ContestHostingModule/views/ContestParticipantsPostScreen.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ReadMoreTextWidget.dart';
import 'package:MediaPlus/MODULES/UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

///template for post of type contest
class EventPostDisplayTemplate extends StatefulWidget {
  final postContent;

  const EventPostDisplayTemplate({Key key, @required this.postContent})
      : super(key: key);
  @override
  _EventPostDisplayTemplateState createState() =>
      _EventPostDisplayTemplateState();
}

class _EventPostDisplayTemplateState extends State<EventPostDisplayTemplate> {
  List _likes;
  bool _isOwner = false;
  String _ownerId;
  String _thisUserId;

  int _numberOfCommnets = 0;
  int _numberOfReactions = 0;

  Color likeButtonColor = Colors.white;

  @override
  void initState() {
    _ownerId = widget.postContent["eventPost"]["postBy"]["_id"].toString();
    _thisUserId = PrimaryUserData.primaryUserData.userId.toString();
    _isOwner = _ownerId == _thisUserId;
    _likes = widget.postContent["likes"];
    _numberOfReactions = _likes.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.0, right: 5.0, left: 5.0),
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(color: Theme.of(context).primaryColor))),
      child: Column(
          //post details like user profile pic and name
          children: [
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
                              widget.postContent["eventPost"]["postBy"]
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
                                widget.postContent["eventPost"]["postBy"]
                                            ["name"]
                                        .toString() +
                                    "  ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0),
                              ),
                              Text(
                                widget.postContent["eventPost"]["postBy"]
                                        ["userName"]
                                    .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            child: DateTime.parse(widget
                                            .postContent["eventPost"]["endsOn"])
                                        .isAfter(DateTime.now()) &&
                                    DateTime.parse(
                                            widget.postContent["eventPost"]
                                                ["startsOn"])
                                        .isBefore(DateTime.now())
                                ? Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Event is Live ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.0),
                                        ),
                                      //  SpinKitPulse(color: Colors.green,size: 10.0,)
                                      ],
                                    ),
                                  )
                                : Container(
                                    child: Text(
                                      "Event Ended",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.0),
                                    ),
                                  ))
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  _isOwner
                      ? TextButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.resolveWith(
                                  (states) => EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 15.0))),
                          child: Text(
                            "Promote",
                          ),
                          onPressed: () {
                            print("object");
                          })
                      : Container(),
                  Container(
                    child: PopupMenuButton<TextButton>(
                      elevation: 0.0,
                      padding: EdgeInsets.all(2.0),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem<TextButton>(
                              child: _isOwner
                                  ? TextButton(
                                      onPressed: () {
                                        print("okay");
                                      },
                                      child: Text('Remove Contest'),
                                    )
                                  : TextButton(
                                      onPressed: () {
                                        print("okay");
                                      },
                                      child: Text('Report'),
                                    ))
                        ];
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
                width: screenWidth,
                padding: EdgeInsets.only(top: 3.0, right: 2.0, left: 2.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.postContent["eventPost"]["eventName"].toString(),
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                )),
            Container(
                width: screenWidth,
                padding: EdgeInsets.only(right: 2.0, left: 2.0),
                alignment: Alignment.centerLeft,
                child: ReadMoreText(
                  widget.postContent["eventPost"]["description"].toString(),
                  trimLines: 4,
                  trimMode: TrimMode.Line,
                  colorClickableText: Colors.blue,
                )),
            GestureDetector(
              onDoubleTap: () {
                reactionCountUpdater(_thisUserId);
              },
              onTap: () {
                Get.to(() => FullScreenImagePostDisplay(
                      imagesData: [
                        {
                          "path": widget.postContent["eventPost"]["poster"]
                              .toString()
                        }
                      ],
                      initialPage: 0,
                    ));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 0.0),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: CachedNetworkImage(
                    imageUrl: ApiUrlsData.domain +
                        widget.postContent["eventPost"]["poster"].toString(),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Container(
              height: 60.0,
              child: Row(
                children: [
                  Container(
                    child: Row(
                      children: [
                        IconButton(
                            icon: _likes.contains(_thisUserId)
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : Icon(
                                    Icons.favorite_border,
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
                            icon: Icon(Icons.comment_bank_outlined),
                            onPressed: () {}),
                        Text(_numberOfCommnets.toString() + " "),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        IconButton(icon: Icon(Icons.share), onPressed: () {}),
                        Text("  1.1k")
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 8.0),
                    child: _isOwner
                        ? Container()
                        : TextButton(
                            onPressed: () {}, child: Text("interested")),
                  )
                ],
              ),
            )
          ]),
    );
  }

  likeButtonColorUpdater() {
    setState(() {
      likeButtonColor =
          likeButtonColor == Colors.white ? Colors.red : Colors.white;
    });
  }

  commentCountUpdater(int count) {
    setState(() {
      _numberOfCommnets = count;
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
