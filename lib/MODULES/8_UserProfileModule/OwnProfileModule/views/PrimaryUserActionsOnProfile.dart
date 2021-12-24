import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/CommonPostDisplayPageScreen.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OwnProfileModule/views/EditProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrimaryUserActionsOnProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.0, bottom: 4.0),
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Container(
        height: 25.0,
        width: screenWidth,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: TextButton(
                  child: Container(
                      alignment: Alignment.center, child: Text("Edit Profile")),
                  onPressed: () {
                    Get.to(() => EditProfileScreen());
                  }),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: TextButton(
                  child: Container(
                      alignment: Alignment.center, child: Text("Promotions")),
                  onPressed: () {
                    // Get.to(() => CommonPostDisplayPageScreen(
                    //       title: "Promotions",
                    //     ));
                  }),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: TextButton(
                  child: Container(
                      alignment: Alignment.center, child: Text("Shared Posts")),
                  onPressed: () {
                    Get.to(() => CommonPostDisplayPageScreen(
                          title: "Shared Posts",
                          apiUrl: ApiUrlsData.userSharedPosts,
                          apiData: {
                            "userId": PrimaryUserData.primaryUserData.userId
                                .toString()
                          },
                        ));
                  }),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: TextButton(
                  child: Container(
                      alignment: Alignment.center, child: Text("Mentions")),
                  onPressed: () {
                    Get.to(() => CommonPostDisplayPageScreen(
                          title: "Mentions",
                          apiUrl: ApiUrlsData.userMentionedPosts,
                          apiData: {
                            "userId": PrimaryUserData.primaryUserData.userId
                                .toString()
                          },
                        ));
                  }),
            ),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 8.0),
            //   child: TextButton(
            //       child: Container(
            //           alignment: Alignment.center, child: Text("Events")),
            //       onPressed: () {
            //         Get.to(() => CommonPostDisplayPageScreen(
            //               title: "Events",
            //             ));
            //       }),
            // ),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 8.0),
            //   child: TextButton(
            //       child: Container(
            //           alignment: Alignment.center, child: Text("Contests")),
            //       onPressed: () {
            //         Get.to(() => CommonPostDisplayPageScreen(
            //               title: "Contests",
            //             ));
            //       }),
            // ),
          ],
        ),
      ),
    );
  }
}
