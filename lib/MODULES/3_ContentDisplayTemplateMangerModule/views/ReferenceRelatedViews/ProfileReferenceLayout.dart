import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

const double _containerWidth = 120.0;

class ProfileReferenceLayout extends StatefulWidget {
  final boxContents;

  const ProfileReferenceLayout({Key key, this.boxContents}) : super(key: key);

  @override
  _ProfileReferenceLayoutState createState() => _ProfileReferenceLayoutState();
}

class _ProfileReferenceLayoutState extends State<ProfileReferenceLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      height: 230.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(widget.boxContents["title"].toString()),
          ),
          Container(
            height: 200.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var i in widget.boxContents["data"])
                  Container(
                    width: 150.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
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
                                        i["profilePic"].toString(),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            i["name"].toString(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          height: 30.0,
                          child: Container(
                              alignment: Alignment.center,
                              child: _getFollowButton(i["_id"])),
                        )
                      ],
                    ),
                  )
              ],
            ),
          ),
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

  TextButton _getFollowButton(String userId) {
    if (PrimaryUserData.primaryUserData.followings.contains(userId)) {
      return TextButton(
          child:
              Container(alignment: Alignment.center, child: Text("Unfollow")),
          onPressed: () {
            _unFollowUser(userId);
          });
    } else if (PrimaryUserData.primaryUserData.followers.contains(userId)) {
      return TextButton(
          child: Container(
              alignment: Alignment.center, child: Text("Follow Back")),
          onPressed: () {
            _followUser(userId);
          });
    } else {
      return TextButton(
          child: Container(alignment: Alignment.center, child: Text("Follow")),
          onPressed: () {
            _followUser(userId);
          });
    }
  }
}
