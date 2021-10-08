import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OthersProfileModule/views/OtherUserProfilePageScreen.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HorizontalProfileReferenceTemplate extends StatefulWidget {
  final userData;

  const HorizontalProfileReferenceTemplate(
      {Key key, @required this.userData})
      : super(key: key);

  @override
  State<HorizontalProfileReferenceTemplate> createState() =>
      _HorizontalProfileReferenceTemplateState();
}

class _HorizontalProfileReferenceTemplateState
    extends State<HorizontalProfileReferenceTemplate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  width: 0.5, color: Theme.of(context).secondaryHeaderColor))),
      child: ListTile(
        horizontalTitleGap: 3.0,
        onTap: () {
          Get.to((OtherUserProfilePageScreen(
              profileOwnerId:widget.userData["_id"])));
        },
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            height: 35.0,
            width: 35.0,
            child: CachedNetworkImage(
              imageUrl:
                  ApiUrlsData.domain + widget.userData["profilePic"],
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(widget.userData["name"].toString()),
        // subtitle: Text(
        //     controller.data[index]["userName"].toString()),
        trailing: getFollowButton(widget.userData["_id"]),
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

  TextButton getFollowButton(String userId) {
    if (PrimaryUserData.primaryUserData.followings.contains(userId)) {
      return TextButton(
          child: Container(child: Text("Unfollow")),
          onPressed: () {
            unFollowUser(userId);
          });
    } else if (PrimaryUserData.primaryUserData.followers.contains(userId)) {
      return TextButton(
          child: Container(child: Text("Follow Back")),
          onPressed: () {
            followUser(userId);
          });
    } else {
      return TextButton(
          child: Container(child: Text("Follow")),
          onPressed: () {
            followUser(userId);
          });
    }
  }
}
