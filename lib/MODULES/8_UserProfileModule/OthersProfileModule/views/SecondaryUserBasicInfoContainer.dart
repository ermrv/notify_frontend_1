import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/UserFollowersList.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../UserFollowingsList.dart';

///
///all the data for this widget is derived from the [PrimaryUserDataModel]
class SecondaryUserBasicInfoContainer extends StatelessWidget {
  final basicUserData;

  const SecondaryUserBasicInfoContainer({Key key, @required this.basicUserData})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 3.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Stack(
              children: [
                Container(
                  height: 300.0,
                  width: screenWidth,
                ),
                Positioned(
                  child: Container(
                    height: 250.0,
                    width: screenWidth,
                    child: Image.asset(
                      "assets/nature.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    left: 5.0,
                    child: Hero(
                      tag: "host-user-profile-picture",
                      child: Container(
                        height: 110.0,
                        width: 110.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).accentColor,
                                width: 2.0)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: CachedNetworkImage(
                            imageUrl: ApiUrlsData.domain +
                                basicUserData["profilePic"],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 50.0,
                    width: screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 100.0,
                        ),

                        ///followers button
                        Container(
                          child: Stack(
                            children: [
                              Container(
                                width: 100.0,
                                margin: EdgeInsets.only(top: 19.0),
                                child: TextButton(
                                  onPressed: () {
                                    Get.to(() => UserFollowersList(
                                          userId:
                                              basicUserData["_id"].toString(),
                                        ));
                                  },
                                  child: Text(
                                    "Followers",
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Container(
                                  width: 100.0,
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    // basicUserData["followers"]
                                    //     .length()
                                    //     .toString(),
                                    "3",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        ///followings button
                        Stack(
                          children: [
                            Container(
                              width: 100.0,
                              margin: EdgeInsets.only(top: 19.0),
                              child: TextButton(
                                onPressed: () {
                                  Get.to(() => UserFollowingsList(
                                        userId: basicUserData["_id"].toString(),
                                      ));
                                },
                                child: Text(
                                  "Followings",
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor),
                                ),
                              ),
                            ),
                            Positioned(
                              child: Container(
                                width: 100.0,
                                alignment: Alignment.topCenter,
                                child: Text(
                                  // basicUserData["followings"]
                                  //     .length()
                                  //     .toString(),
                                  "2",
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 15.0, left: 10.0),
            // color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  basicUserData["name"].toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                basicUserData["bio"] == null
                    ? Container()
                    : Text(
                        basicUserData["bio"].toString(),
                        style: TextStyle(),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
