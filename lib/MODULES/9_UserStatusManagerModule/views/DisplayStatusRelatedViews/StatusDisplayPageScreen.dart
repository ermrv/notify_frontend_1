import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/2_CommentsDisplayManagerModule/views/CommentsDisplayScreen.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/9_UserStatusManagerModule/controllers/DisplayStatusRelatedControllers/StatusDisplayPageController.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ReadMoreTextWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class StatusDisplayPageScreen extends StatelessWidget {
  final List statusData;
  final StatusDisplayPageController controller =
      Get.put(StatusDisplayPageController());

  StatusDisplayPageScreen({Key key, @required this.statusData})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatusDisplayPageController>(
      initState: (state) {
        SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
        controller.statusData = statusData;
      },
      dispose: (state) {
        SystemChrome.setEnabledSystemUIOverlays(
            [SystemUiOverlay.bottom, SystemUiOverlay.top]);
      },
      builder: (controller) => Scaffold(
        backgroundColor: Colors.black,
        body: PageView(
          scrollDirection: Axis.horizontal,
          children: [
            for (var i in controller.statusData)
              _Template(
                content: i,
                controller: controller,
              )
          ],
        ),
      ),
    );
  }
}

class _Template extends StatefulWidget {
  final content;
  final StatusDisplayPageController controller;

  const _Template({Key key, @required this.content, @required this.controller})
      : super(key: key);

  @override
  __TemplateState createState() => __TemplateState();
}

class __TemplateState extends State<_Template> {
  List statusContents;
  int currentIndex = 0;

  String _ownerId;
  String _thisUserId;

  bool _isLiked = false;
  bool _isOwner = false;

  List _likes;

  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    statusContents = widget.content["statusContents"];
    _ownerId = widget.content["userId"]["_id"].toString();
    _thisUserId = PrimaryUserData.primaryUserData.userId.toString();
    _isOwner = _ownerId == _thisUserId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _likes = statusContents[currentIndex]["likes"];
    _isLiked = _likes.contains(_thisUserId);
    return GestureDetector(
      onTapDown: (details) {
        double xCordinate = details.globalPosition.dx;
        if (xCordinate > screenWidth / 2 &&
            details.globalPosition.dy < screenHeight - 100 &&
            currentIndex < statusContents.length - 1) {
          if (this.mounted) {
            setState(() {
              currentIndex = currentIndex + 1;
            });
          }
        } else if (xCordinate < screenWidth / 2 &&
            details.globalPosition.dy < screenHeight - 100 &&
            currentIndex > 0) {
          if (this.mounted) {
            setState(() {
              currentIndex = currentIndex - 1;
            });
          }
        }
      },
      child: Container(
        height: screenHeight,
        width: screenWidth,
        child: Stack(
          children: [
            //status content contianer
            Container(
              height: screenHeight,
              width: screenWidth,
              child: CachedNetworkImage(
                imageUrl:
                    ApiUrlsData.domain + statusContents[currentIndex]["path"],
              ),
            ),
            //user basic details
            Container(
              height: 60.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black38,
                      Colors.black38,
                      Colors.black26,
                      Colors.transparent
                    ]),
              ),
              padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Row(
                children: [
                  Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: CachedNetworkImage(
                        imageUrl: ApiUrlsData.domain +
                            widget.content["userId"]["profilePic"],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 40.0,
                    margin: EdgeInsets.only(left: 5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.content["userId"]["name"].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15.0),
                        ),
                        Text(
                          "4hrs ago",
                          style: TextStyle(fontSize: 12.0),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  _isOwner
                      ? Container(
                          child: IconButton(
                            icon: Icon(Icons.more_vert),
                            onPressed: () {
                              Get.bottomSheet(Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Remove story",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Container(
                                      height: 20.0,
                                    )
                                  ],
                                ),
                              ));
                            },
                          ),
                        )
                      : Container()
                ],
              ),
            ),
            //total number of status hightlighter
            Positioned(
              top: 0.0,
              child: Container(
                width: screenWidth,
                height: 3.0,
                child: Row(
                  children: [
                    for (var j = 0; j < statusContents.length; j++)
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2.0),
                        height: 2.0,
                        width: screenWidth - 4.0 / statusContents.length,
                        decoration: BoxDecoration(
                          color: j == currentIndex ? Colors.red : Colors.white,
                        ),
                      )
                  ],
                ),
              ),
            ),

            //write a comment section
            Positioned(
                bottom: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        end: Alignment.topCenter,
                        begin: Alignment.bottomCenter,
                        colors: [
                          Colors.black54,
                          Colors.black54,
                          Colors.black38,
                          Colors.black26,
                          Colors.black12,
                          Colors.transparent
                        ]),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                  width: screenWidth,
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: 5.0),
                          width: screenWidth - 20.0,
                          child: ReadMoreText(
                            statusContents[currentIndex]["statusText"]
                                .toString(),
                            style: TextStyle(fontSize: 15.0),
                            trimLines: 2,
                            trimMode: TrimMode.Line,
                            colorClickableText: Colors.blue,
                          )),
                      !_isOwner
                          ?
                          //actions for the status owner
                          Container(
                              height: 55.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Icon(Entypo.chevron_thin_up),
                                  ),
                                  Container(
                                    height: 30.0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Ionicons.md_eye),
                                        Text(
                                          " " +
                                              statusContents[currentIndex]
                                                      ["seenBy"]
                                                  .length
                                                  .toString(),
                                        ),
                                        Container(
                                          width: 20.0,
                                        ),
                                        GestureDetector(
                                          onTap: () => Get.to(() =>
                                              CommentsDisplayScreen(
                                                  postId: statusContents[
                                                          currentIndex]["_id"]
                                                      .toString())),
                                          child: Icon(
                                            EvilIcons.comment,
                                            size: 28.0,
                                          ),
                                        ),
                                        Text(
                                          " " +
                                              statusContents[currentIndex]
                                                      ["comments"]
                                                  .length
                                                  .toString(),
                                        ),
                                        Container(
                                          width: 20.0,
                                        ),
                                        Icon(
                                          Octicons.heart,
                                          size: 24.0,
                                          color: Colors.red,
                                        ),
                                        Text(" " + _likes.length.toString()),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          :
                          //actions for other users
                          Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    child: IconButton(
                                      onPressed: () {
                                        reactionUpdater(_thisUserId);
                                      },
                                      icon: _isLiked
                                          ? Icon(
                                              Octicons.heart,
                                              size: 30.0,
                                              color: Colors.red,
                                            )
                                          : Icon(
                                              EvilIcons.heart,
                                              size: 34.0,
                                              color: Colors.white,
                                            ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      margin: EdgeInsets.only(right: 5.0),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .accentColor
                                                  .withOpacity(0.5)),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: TextFormField(
                                                controller: _controller,
                                                maxLines: null,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    hintText:
                                                        "write a comment...."),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: IconButton(
                                              icon: Icon(Icons.send),
                                              onPressed: () {
                                                widget.controller
                                                    .addStatusComment(
                                                        widget.content["_id"],
                                                        _controller.text);
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  statusContents[currentIndex]["comments"]
                                          .contains(_thisUserId)
                                      ? Container(
                                          margin: EdgeInsets.only(bottom: 10.0),
                                          child: Icon(
                                            EvilIcons.comment,
                                            size: 32.0,
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  //reaction count updater
  reactionUpdater(String userId) {
    if (_likes.contains(userId)) {
      _likes.remove(userId);
      setState(() {});
    } else {
      _likes.add(userId);
      setState(() {});
    }
  }
}
