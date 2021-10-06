import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/BelowPostCommentDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/CommentsDisplayScreen.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/UserActionsOnPost/OtherUserActionsOnPost.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/UserActionsOnPost/PostOwnerActionsOnPost.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/UserProfileScreen.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/TimeStampProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class PollPostDisplayTemplate extends StatefulWidget {
  final postContent;
  final parentController;

  const PollPostDisplayTemplate(
      {Key key, this.postContent, @required this.parentController})
      : super(key: key);

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

  //poll post related variables
  List<String> totalPolls;
  List<String> opOnePolls;
  List<String> opTwoPolls;
  List<String> opThreePolls;
  List<String> opFourPolls;

  bool _isPollCasted = false;

  @override
  void initState() {
    _ownerId = widget.postContent["pollPost"]["postBy"]["_id"].toString();
    _thisUserId = PrimaryUserData.primaryUserData.userId.toString();
    _isOwner = _ownerId == _thisUserId;
    _likes = widget.postContent["likes"];
    _numberOfReactions = _likes.length;
//polls calculations
    totalPolls = widget.postContent["pollPost"]["totalResponse"];
    opOnePolls = widget.postContent["pollPost"]["opOneResponse"];
    opTwoPolls = widget.postContent["pollPost"]["opTwoResponse"];
    opThreePolls = widget.postContent["pollPost"]["opThreeResponse"];
    opFourPolls = widget.postContent["pollPost"]["opFourResponse"];

    pollCastUpdater();

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
                //basic info of the post
                Container(
                  height: 50.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //
                      //
                      //user profile pic
                      GestureDetector(
                        onTap: () {
                          Get.to(() => UserProfileScreen(
                                profileOwnerId: widget.postContent["pollPost"]
                                    ["postBy"]["_id"],
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.all(1.0),
                          height: 35.0,
                          width: 35.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.deepOrange[900]),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: CachedNetworkImage(
                                imageUrl: ApiUrlsData.domain +
                                    widget.postContent["pollPost"]["postBy"]
                                        ["profilePic"],
                                fit: BoxFit.fill,
                              )),
                        ),
                      ),
                      //
                      //
                      //user name,userName and location
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
                                ],
                              ),
                            ),
                            Container(
                              child: Text(
                                TimeStampProvider.timeStampProvider(
                                    widget.postContent["createdAt"].toString()),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.0),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),

                      //actions on post
                      _isOwner
                          ? PostOwnerActionsOnPost(
                              postId: widget.postContent["_id"].toString(),
                              postDescription: widget.postContent["pollPost"]
                                      ["description"]
                                  .toString(),
                              editedDescriptionUpdater: (String description) {
                                // updateEditedDescription(description);
                              },
                              parentController: widget.parentController,
                            )
                          : OtherUserActionsOnPost(
                              postUserId: widget.postContent["pollPost"]
                                      ["postBy"]["_id"]
                                  .toString(),
                              postId: widget.postContent["_id"].toString(),
                            )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  child: Text(
                    widget.postContent["pollPost"]["description"],
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Theme.of(context).accentColor.withOpacity(0.9)),
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
                              if (opOnePolls.contains(_thisUserId)) {
                                totalPolls.remove(_thisUserId);
                                opOnePolls.remove(_thisUserId);
                                castPollHandler();
                              } else {
                                totalPolls.add(_thisUserId);
                                opOnePolls.add(_thisUserId);
                                castPollHandler();
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
                                    fontWeight: FontWeight.normal,
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.9)),
                              ),
                              _isPollCasted
                                  ? Text(
                                      ((opOnePolls.length / totalPolls.length) *
                                                  100)
                                              .toString() +
                                          "%")
                                  : Container()
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
                              if (opOnePolls.contains(_thisUserId)) {
                                totalPolls.remove(_thisUserId);
                                opTwoPolls.remove(_thisUserId);
                                castPollHandler();
                              } else {
                                totalPolls.add(_thisUserId);
                                opTwoPolls.add(_thisUserId);
                                castPollHandler();
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
                                    fontWeight: FontWeight.normal,
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.9)),
                              ),
                              _isPollCasted
                                  ? Text(
                                      ((opTwoPolls.length / totalPolls.length) *
                                                  100)
                                              .toString() +
                                          "%")
                                  : Container()
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
                              if (opOnePolls.contains(_thisUserId)) {
                                totalPolls.remove(_thisUserId);
                                opThreePolls.remove(_thisUserId);
                                castPollHandler();
                              } else {
                                totalPolls.add(_thisUserId);
                                opThreePolls.add(_thisUserId);
                                castPollHandler();
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
                                    fontWeight: FontWeight.normal,
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.9)),
                              ),
                              _isPollCasted
                                  ? Text(
                                      ((opThreePolls.length / totalPolls.length) *
                                                  100)
                                              .toString() +
                                          "%")
                                  : Container()
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
                              if (opOnePolls.contains(_thisUserId)) {
                                totalPolls.remove(_thisUserId);
                                opFourPolls.remove(_thisUserId);
                                castPollHandler();
                              } else {
                                totalPolls.add(_thisUserId);
                                opFourPolls.add(_thisUserId);
                                castPollHandler();
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
                                    fontWeight: FontWeight.normal,
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.9)),
                              ),
                              _isPollCasted
                                  ? Text(
                                      ((opFourPolls.length / totalPolls.length) *
                                                  100)
                                              .toString() +
                                          "%")
                                  : Container()
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
                                  commentCountUpdater: (int commentCount) {
                                    commentCountUpdater(commentCount);
                                  },
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
                      // Text(" 1.1k")
                    ],
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
          widget.postContent["comments"] == null
              ? Container()
              : widget.postContent["comments"].length == 0
                  ? Container()
                  : BelowPostCommentDisplayTemplate(
                      commentData: widget.postContent["comments"][0],
                      postId: widget.postContent["_id"],
                      commentCountUpdater: (int count) {
                        commentCountUpdater(count);
                      },
                    )
        ],
      ),
    );
  }

  //checking if the user has already casted the poll
  pollCastUpdater() {
    if (totalPolls.contains(_thisUserId)) {
      //check which option is selected
      if (opOnePolls.contains(_thisUserId)) {
        setState(() {
          _isPollCasted = true;
          _vote = widget.postContent["pollPost"]["opOne"].toString();
        });
      } else if (opTwoPolls.contains(_thisUserId)) {
        setState(() {
          _isPollCasted = true;
          _vote = widget.postContent["pollPost"]["opTwo"].toString();
        });
      } else if (opThreePolls.contains(_thisUserId)) {
        setState(() {
          _isPollCasted = true;
          _vote = widget.postContent["pollPost"]["opThree"].toString();
        });
      } else if (opFourPolls.contains(_thisUserId)) {
        setState(() {
          _isPollCasted = true;
          _vote = widget.postContent["pollPost"]["opFour"].toString();
        });
      }
    } else {
      setState(() {
        _vote = "";
        _isPollCasted = false;
      });
    }
  }

  ///call the function when user cas a poll
  castPollHandler() {
    pollCastUpdater();
  }

  commentCountUpdater(int count) {
    setState(() {
      _numberOfComments = count;
    });
  }

  //reaction count updater
  reactionCountUpdater(String userId) async {
    if (_likes.contains(userId)) {
      _likes.remove(userId);
      setState(() {
        _numberOfReactions = _likes.length;
      });
      var response = await ApiServices.postWithAuth(ApiUrlsData.postReaction,
          {"postId": widget.postContent["_id"], "like": false}, userToken);
      if (response == "error") {
        Get.snackbar("Somethings wrong", "Your reaction is not updated");
      }
    } else {
      _likes.add(userId);
      setState(() {
        _numberOfReactions = _likes.length;
      });
      var response = await ApiServices.postWithAuth(ApiUrlsData.postReaction,
          {"postId": widget.postContent["_id"], "like": true}, userToken);
      if (response == "error") {
        Get.snackbar("Somethings wrong", "Your reaction is not updated");
      }
    }
  }
}
