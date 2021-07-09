import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/CommentsDisplayManagerModule/views/CommentsDisplayScreen.dart';
import 'package:MediaPlus/MODULES/UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class PollPostDisplayTemplate extends StatefulWidget {
  final postContent;

  const PollPostDisplayTemplate({Key key, this.postContent}) : super(key: key);

  @override
  _PollPostDisplayTemplateState createState() =>
      _PollPostDisplayTemplateState();
}

class _PollPostDisplayTemplateState extends State<PollPostDisplayTemplate> {
  List _likes;
  bool _isOwner = false;
  String _ownerId;
  String _thisUserId;

  String _vote = "";

  int _numberOfComments = 0;
  int _numberOfReactions = 0;

  Color likeButtonColor = Colors.white;

  @override
  void initState() {
    _ownerId = widget.postContent["pollPost"]["postBy"]["_id"].toString();
    _thisUserId = PrimaryUserData.primaryUserData.userId.toString();
    _isOwner = _ownerId == _thisUserId;
    _likes = widget.postContent["likes"];
    _numberOfReactions = _likes.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  widget.postContent["pollPost"]["postBy"]
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
                                    widget.postContent["pollPost"]["postBy"]
                                                ["name"]
                                            .toString() +
                                        "  ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.0),
                                  ),
                                  Text(
                                    widget.postContent["pollPost"]["postBy"]
                                            ["userName"]
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.0),
                                  ),
                                ],
                              ),
                            ),
                            // Container(
                            //     child: DateTime.parse(widget
                            //                 .postContent["pollPost"]["endsOn"])
                            //             .isAfter(DateTime.now())
                            //         ? Container(
                            //             child: Row(
                            //               crossAxisAlignment:
                            //                   CrossAxisAlignment.center,
                            //               children: [
                            //                 Text(
                            //                   'Poll is Live ',
                            //                   style: TextStyle(
                            //                       fontWeight: FontWeight.bold,
                            //                       fontSize: 13.0),
                            //                 ),
                            //                 SpinKitThreeBounce(
                            //                   color: Colors.green,
                            //                   size: 10.0,
                            //                 )
                            //               ],
                            //             ),
                            //           )
                            //         : Container(
                            //             child: Text(
                            //               "Poll Ended",
                            //               style: TextStyle(
                            //                   fontWeight: FontWeight.bold,
                            //                   fontSize: 13.0),
                            //             ),
                            //           ))
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
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  child: Text(
                    widget.postContent["pollPost"]["description"],
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                //option one
                widget.postContent["pollPost"]["opOne"] == null
                    ? Container()
                    : Container(
                        height: 45.0,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 3.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (state) => Colors.transparent),
                          ),
                          onPressed: () {
                            setState(() {
                              if (_vote ==
                                  widget.postContent["pollPost"]["opOne"]) {
                                _vote = "";
                              } else {
                                _vote = widget.postContent["pollPost"]["opOne"]
                                    .toString();
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Radio(
                                  value: widget.postContent["pollPost"]["opOne"]
                                      .toString(),
                                  toggleable: true,
                                  groupValue: _vote,
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      _vote = value;
                                    });
                                  }),
                              Text(
                                widget.postContent["pollPost"]["opOne"]
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Theme.of(context).accentColor),
                              ),
                            ],
                          ),
                        )),
                // option two
                widget.postContent["pollPost"]["opTwo"] == null
                    ? Container()
                    : Container(
                        height: 45.0,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 3.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (state) => Colors.transparent),
                          ),
                          onPressed: () {
                            setState(() {
                              if (_vote ==
                                  widget.postContent["pollPost"]["opTwo"]) {
                                _vote = "";
                              } else {
                                _vote = widget.postContent["pollPost"]["opTwo"]
                                    .toString();
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Radio(
                                  value: widget.postContent["pollPost"]["opTwo"]
                                      .toString(),
                                  toggleable: true,
                                  groupValue: _vote,
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      _vote = value;
                                    });
                                  }),
                              Text(
                                widget.postContent["pollPost"]["opTwo"]
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Theme.of(context).accentColor),
                              ),
                            ],
                          ),
                        )),
                //option three
                widget.postContent["pollPost"]["opThree"] == null
                    ? Container()
                    : Container(
                        height: 45.0,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 3.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (state) => Colors.transparent),
                          ),
                          onPressed: () {
                            setState(() {
                              if (_vote ==
                                  widget.postContent["pollPost"]["opThree"]) {
                                _vote = "";
                              } else {
                                _vote = widget.postContent["pollPost"]
                                        ["opThree"]
                                    .toString();
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Radio(
                                  value: widget.postContent["pollPost"]
                                          ["opThree"]
                                      .toString(),
                                  toggleable: true,
                                  groupValue: _vote,
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      _vote = value;
                                    });
                                  }),
                              Text(
                                widget.postContent["pollPost"]["opThree"]
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Theme.of(context).accentColor),
                              ),
                            ],
                          ),
                        )),
                //option four
                widget.postContent["pollPost"]["opFour"] == null
                    ? Container()
                    : Container(
                        height: 45.0,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 3.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (state) => Colors.transparent),
                          ),
                          onPressed: () {
                            setState(() {
                              if (_vote ==
                                  widget.postContent["pollPost"]["opFour"]) {
                                _vote = "";
                              } else {
                                _vote = widget.postContent["pollPost"]["opFour"]
                                    .toString();
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Radio(
                                  value: widget.postContent["pollPost"]
                                          ["opFour"]
                                      .toString(),
                                  toggleable: true,
                                  groupValue: _vote,
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      _vote = value;
                                    });
                                  }),
                              Text(
                                widget.postContent["pollPost"]["opFour"]
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Theme.of(context).accentColor),
                              ),
                            ],
                          ),
                        )),
              ],
            ),
          ),
          Container(
            height: 60.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: _likes.contains(
                            _thisUserId,
                          )
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
                          icon: Icon(
                            EvilIcons.comment,
                            size: 28.0,
                          ),
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
                      IconButton(
                          icon: Icon(MaterialCommunityIcons.share),
                          onPressed: () {}),
                      Text(" 1.1k")
                    ],
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          )
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
