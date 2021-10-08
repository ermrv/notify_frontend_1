import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OthersProfileModule/views/OtherUserProfilePageScreen.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileReferenceTemplate extends StatefulWidget {
  final userData;
  final bool showVerticalTemplate;

  const ProfileReferenceTemplate(
      {Key key, @required this.userData, @required this.showVerticalTemplate})
      : super(key: key);

  @override
  State<ProfileReferenceTemplate> createState() =>
      _ProfileReferenceTemplateState();
}

class _ProfileReferenceTemplateState extends State<ProfileReferenceTemplate> {
  @override
  Widget build(BuildContext context) {
    return widget.showVerticalTemplate
        ? Container(
            width: 150.0,
            margin: EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).accentColor, width: 0.5),
                borderRadius: BorderRadius.circular(5.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: SizedBox(
                    height: 130.0,
                    width: 130,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: AspectRatio(
                          aspectRatio: 1.0,
                          child: CachedNetworkImage(
                            imageUrl: ApiUrlsData.domain +
                                widget.userData["profilePic"].toString(),
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    widget.userData["name"].toString(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  height: 30.0,
                  child: Container(
                      alignment: Alignment.center,
                      child: getFollowButton(widget.userData["_id"], true)),
                )
              ],
            ),
          )
        : Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        width: 0.5,
                        color: Theme.of(context).secondaryHeaderColor))),
            child: ListTile(
              horizontalTitleGap: 3.0,
              onTap: () {
                Get.to((OtherUserProfilePageScreen(
                    profileOwnerId: widget.userData["_id"])));
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
              trailing: getFollowButton(widget.userData["_id"], false),
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
              ? Container(alignment: Alignment.center, child: Text("Follow Back"))
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
