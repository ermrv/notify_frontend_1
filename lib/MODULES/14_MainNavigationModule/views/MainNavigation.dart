import 'package:MediaPlus/MODULES/15_NotificationModule/NotificationPage.dart';
import 'package:MediaPlus/MODULES/17_ShortVideoPlayerModule/views/ShortVideoPlayerPageScreen.dart';
import 'package:MediaPlus/MODULES/5_ExplorePageModule/views/ExplorePageDisplayScreen.dart';

import 'package:MediaPlus/MODULES/6_HomePageModule/views/HomePageScreen.dart';
import 'package:MediaPlus/MODULES/14_MainNavigationModule/controllers/MainNavigationController.dart';
import 'package:MediaPlus/MODULES/14_MainNavigationModule/views/CustomBottomNavigationBar.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/UserProfileScreen.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/KeepWidgetAliveModule/KeepWidgetAliveWrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

///main navigation screen containg the bottom tabs [HomeScreen],[ExploreScreen],[AddPostScreen],[RewardsScreen],and [ChatScreen]
///

class MainNavigationScreen extends StatelessWidget {
  final int tabNumber;
  final mainNavigationController = Get.put(MainNavigationController());

  MainNavigationScreen({Key key, this.tabNumber}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainNavigationController>(
        initState: (state) {
          mainNavigationController.currentIndex =
              tabNumber == null ? 0 : tabNumber;
        },
        builder: (controller) => Scaffold(
              extendBody: true,
              bottomNavigationBar: AnimatedContainer(
                height: controller.height,
                duration: Duration(milliseconds: 300),
                child: CustomBottomNavigationBar(
                  itemColor: Theme.of(context).accentColor,
                  currentIndex: controller.currentIndex,
                  onChange: (index) {
                    controller.pageTransitionHandler(index);
                  },
                  children: [
                    CustomBottomNavigationItem(
                      icon: Icons.home,
                      label: 'Home',
                    ),
                    CustomBottomNavigationItem(
                      icon: Icons.explore,
                      label: 'Explore',
                    ),
                    CustomBottomNavigationItem(
                      icon: Icons.music_video,
                      label: 'Shorts',
                    ),
                    CustomBottomNavigationItem(
                      suffix: Text(
                        "7",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w700),
                      ),
                      icon: Icons.notifications,
                      label: 'Notifications',
                    ),
                    CustomBottomNavigationItem(
                      imageUrl: PrimaryUserData.primaryUserData.profilePic.value
                          .toString(),
                      label: 'Profile',
                    )
                  ],
                ),
              ),

              //bottom tab bar screens
              body: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: controller.pageController,
                children: [
                  HomeScreen(),
                  ExplorePageDisplayScreen(),
                  ShortVideoPlayerPageScreen(),
                  NotificationPage(),
                  UserProfileScreen(
                    profileOwnerId: PrimaryUserData.primaryUserData.userId,
                  ),
                ],
              ),
            ));
  }
}
