import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';

class OtherUserActionsOnPost extends StatefulWidget {
  final String postUserId;
  final String postId;

  const OtherUserActionsOnPost(
      {Key key, @required this.postUserId, @required this.postId})
      : super(key: key);

  @override
  State<OtherUserActionsOnPost> createState() => _OtherUserActionsOnPostState();
}

class _OtherUserActionsOnPostState extends State<OtherUserActionsOnPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            )),
            PopupMenuItem<TextButton>(
                child: getFollowButton(widget.postUserId, false)),
            PopupMenuItem<TextButton>(
                child: TextButton(
              onPressed: () {
                print("okay");
              },
              child: Text('Report'),
            )),
          ];
        },
      ),
    );
  }

  followUser(String userId) async {
    PrimaryUserData.primaryUserData.followings.add(userId);
    setState(() {});
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

  unFollowUser(String userId) async {
    PrimaryUserData.primaryUserData.followings.remove(userId);
    setState(() {});
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

  TextButton getFollowButton(String userId, bool isCenterAligned) {
    if (PrimaryUserData.primaryUserData.followings.contains(userId)) {
      return TextButton(
          child: isCenterAligned
              ? Container(alignment: Alignment.center, child: Text("Unfollow"))
              : Container(child: Text("Unfollow")),
          onPressed: () {
            unFollowUser(userId);
          });
    } else if (PrimaryUserData.primaryUserData.followers.contains(userId)) {
      return TextButton(
          child: isCenterAligned
              ? Container(
                  alignment: Alignment.center, child: Text("Follow Back"))
              : Container(child: Text("Follow Back")),
          onPressed: () {
            followUser(userId);
          });
    } else {
      return TextButton(
          child: isCenterAligned
              ? Container(alignment: Alignment.center, child: Text("Follow"))
              : Container(child: Text("Follow")),
          onPressed: () {
            followUser(userId);
          });
    }
  }
}
