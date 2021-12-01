import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/CommonPostDisplayPageScreen.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondaryUserActionsOnProfile extends StatefulWidget {
  final String profileId;

  const SecondaryUserActionsOnProfile({Key key, @required this.profileId})
      : super(key: key);

  @override
  _SecondaryUserActionsOnProfileState createState() =>
      _SecondaryUserActionsOnProfileState();
}

class _SecondaryUserActionsOnProfileState
    extends State<SecondaryUserActionsOnProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.0, bottom: 4.0),
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: _getFollowButton(),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
                child: Container(
                    alignment: Alignment.center, child: Text("Shared")),
                onPressed: () {
                  Get.to(() => CommonPostDisplayPageScreen(
                        title: "Shared",
                        apiUrl: ApiUrlsData.otherUserPosts,
                        apiData: {"type": "image", "userId": widget.profileId},
                      ));
                }),
          ),
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: 8.0),
          //   child: TextButton(
          //       child: Container(
          //           alignment: Alignment.center, child: Text("Videos")),
          //       onPressed: () {
          //         Get.to(() => CommonPostDisplayPageScreen(
          //               title: "Videos",
          //               apiUrl: ApiUrlsData.otherUserPosts,
          //               apiData: {
          //                 "type": "video",
          //                 "userId": widget.profileId
          //               },
          //             ));
          //       }),
          // ),
        ],
      ),
    );
  }

  //follow user
  _followUser(String userId) async {
    setState(() {
      PrimaryUserData.primaryUserData.followings.add(userId);
    });
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.followUser, {"userId": userId}, userToken);
    if (response != "error") {
      try {
        PrimaryUserData.primaryUserData.deleteLocalUserBasicDataFile();
      } catch (e) {
        print(e);
      }
    }
  }

  //unfollow user
  _unFollowUser(String userId) async {
    setState(() {
      PrimaryUserData.primaryUserData.followings.remove(userId);
    });
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.unfollowUser, {"userId": userId}, userToken);
    if (response != "error") {
      try {
        PrimaryUserData.primaryUserData.deleteLocalUserBasicDataFile();
      } catch (e) {
        print(e);
      }
    }
  }

  TextButton _getFollowButton() {
    if (PrimaryUserData.primaryUserData.followings.contains(widget.profileId)) {
      return TextButton(
          child:
              Container(alignment: Alignment.center, child: Text("Unfollow")),
          onPressed: () {
            _unFollowUser(widget.profileId);
          });
    } else if (PrimaryUserData.primaryUserData.followers
        .contains(widget.profileId)) {
      return TextButton(
          child: Container(
              alignment: Alignment.center, child: Text("Follow Back")),
          onPressed: () {
            _followUser(widget.profileId);
          });
    } else {
      return TextButton(
          child: Container(alignment: Alignment.center, child: Text("Follow")),
          onPressed: () {
            _followUser(widget.profileId);
          });
    }
  }
}
