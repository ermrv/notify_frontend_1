import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/UserStatusManagerModule/controllers/StatusDisplayPageController.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ReadMoreTextWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class StatusDisplayPageScreen extends StatelessWidget {
  final List statusData;
  final controller = Get.put(StatusDisplayPageController());

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
  final controller;

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

  @override
  void initState() {
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
    return Container(
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
            margin: EdgeInsets.only(top: 10.0, left: 10.0),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.content["userId"]["name"].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15.0),
                      ),
                      Text("4hrs ago")
                    ],
                  ),
                )
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
                      width: screenWidth / statusContents.length -
                          4.0 * statusContents.length,
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
              bottom: 5.0,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
                width: screenWidth,
                child: Column(
                  children: [
                    Container(
                        width: screenWidth - 20.0,
                        child: ReadMoreText(
                          statusContents[currentIndex]["statusText"].toString(),
                          style: TextStyle(fontSize: 15.0),
                          trimLines: 2,
                          trimMode: TrimMode.Line,
                          colorClickableText: Colors.blue,
                        )),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              margin: EdgeInsets.only(left: 5.0),
                              height: 50.0,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "write a comment...."),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
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
