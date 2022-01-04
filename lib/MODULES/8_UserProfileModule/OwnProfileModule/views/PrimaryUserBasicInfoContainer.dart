import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OwnProfileModule/views/ShowCoverPicScreen.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/ProfileCommonModules/views/UserFollowersListPageScreen.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/ProfileCommonModules/views/UserFollowingsListPageScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ShowProfilePicScreen.dart';

///
///all the data for this widget is derived from the [PrimaryUserDataModel]
class PrimaryUserBasicInfoContainer extends StatelessWidget {
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
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => ShowCoverPicScreen());
                    },
                    child: Container(
                        height: 250.0,
                        width: screenWidth,
                        child: Obx(() => CachedNetworkImage(
                              imageUrl: PrimaryUserData
                                  .primaryUserData.coverPic.value
                                  .toString(),
                              fit: BoxFit.cover,
                            ))),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    left: 5.0,
                    child: Hero(
                      tag: "host-user-profile-picture",
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => ShowProfilePicScreen());
                        },
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
                              child: Obx(
                                () => CachedNetworkImage(
                                  imageUrl: PrimaryUserData
                                      .primaryUserData.profilePic.value,
                                  fit: BoxFit.cover,
                                ),
                              )),
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
                                    Get.to(() => UserFollowersListPageScreen(
                                          userId: PrimaryUserData
                                              .primaryUserData.userId,
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
                                    PrimaryUserData
                                        .primaryUserData.followers.length
                                        .toString(),
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
                                  Get.to(() => UserFollowingsListPageScreen(
                                        userId: PrimaryUserData
                                            .primaryUserData.userId,
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
                                  PrimaryUserData
                                      .primaryUserData.followings.length
                                      .toString(),
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
                ),
                
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
                Obx(
                  () => Text(
                    PrimaryUserData.primaryUserData.name.toString(),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                ),
                PrimaryUserData.primaryUserData.bio.value == null ||
                        PrimaryUserData.primaryUserData.bio.value == ""
                    ? Container()
                    : Text(
                        PrimaryUserData.primaryUserData.bio.toString(),
                        style: TextStyle(fontSize: 16.0),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
