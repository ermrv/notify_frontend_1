import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/9_UserStatusManagerModule/views/AddStatusRelatedViews/AddStatusScreen.dart';
import 'package:MediaPlus/MODULES/9_UserStatusManagerModule/views/DisplayStatusRelatedViews/StatusDisplayPageScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const double _containerWidth = 65.0;

class UserStatusReferenceLayout extends StatelessWidget {
  final boxContents;

  const UserStatusReferenceLayout({Key key, this.boxContents})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
      height: _containerWidth + 16,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _AddStatusButtonContainer(),
          for (var i in boxContents)
            _Template(
              boxContents: boxContents,
              content: i,
            ),
        ],
      ),
    );
  }
}

class _Template extends StatelessWidget {
  final List boxContents;
  final content;

  const _Template({Key key, this.content, this.boxContents}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => StatusDisplayPageScreen(
              statusData: boxContents,
            ));
      },
      child: Container(
        height: _containerWidth,
        width: _containerWidth,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue[200], width: 2.0),
          shape: BoxShape.circle,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            50.0,
          ),
          child: content["userId"]["profilePic"] == null
              ? Image.asset("assets/person.jpg")
              : CachedNetworkImage(
                  imageUrl:
                      ApiUrlsData.domain + content["userId"]["profilePic"],
                  fit: BoxFit.fill,
                ),
        ),
      ),
    );
  }
}

class _AddStatusButtonContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AddStatusScreen());
      },
      child: Stack(
        children: [
          //post
          Container(
            width: _containerWidth,
            height: _containerWidth,
            margin: EdgeInsets.only(right: 4.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: PrimaryUserData.primaryUserData.profilePic == null
                  ? Image.asset(
                      "assets/person.jpg",
                      fit: BoxFit.fill,
                    )
                  : CachedNetworkImage(
                      imageUrl:
                          PrimaryUserData.primaryUserData.profilePic.toString(),
                      fit: BoxFit.fill,
                    ),
            ),
          ),
          Positioned(
            bottom: 5.0,
            right: 5.0,
            child: Container(
              width: 20.0,
              height: 20.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.add,
                size: 16.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
