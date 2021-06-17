import 'package:MediaPlus/MODULES/AddPostModule/views/AddPostPageScreen.dart';

import 'package:MediaPlus/MODULES/ExplorePageModule/views/ExplorePageScreen.dart';
import 'package:MediaPlus/MODULES/HomePageModule/views/HomePageScreen.dart';
import 'package:MediaPlus/MODULES/MainNavigationModule/controllers/MainNavigationController.dart';
import 'package:MediaPlus/MODULES/MainNavigationModule/views/CustomBottomNavigationBar.dart';
import 'package:MediaPlus/MODULES/UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/UserProfileModule/views/UserProfileScreen.dart';
import 'package:MediaPlus/MODULES/RewardsPageModule/views/RewardsPageScreen.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/KeepWidgetAliveModule/KeepWidgetAliveWrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

///main navigation screen containg the bottom tabs [HomeScreen],[ExploreScreen],[AddPostScreen],[RewardsScreen],and [ChatScreen]
///

class MainNavigationScreen extends StatelessWidget {
  final mainNavigationController = Get.put(MainNavigationController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainNavigationController>(
        builder: (controller) => NotificationListener<UserScrollNotification>(
              onNotification: (notification) => mainNavigationController
                  .bottomNavigationbarViewHandler(notification),
              child: Scaffold(
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
                        icon: Icons.add_box,
                        label: 'Post',
                      ),
                      CustomBottomNavigationItem(
                        suffix: Text(
                          "7",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w700),
                        ),
                        icon: Icons.emoji_events,
                        label: 'Rewards',
                      ),
                      CustomBottomNavigationItem(
                        imageUrl: PrimaryUserData.primaryUserData.profilePic,
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
                    ExplorePageScreen(),
                    AddPostPageScreen(),
                    RewardaPageScreen(),
                    KeepWidgetAliveWrapper(child: UserProfileScreen()),
                    // HomeScreen(),
                    // ExploreScreen(),
                    // AddPostScreen(),
                    // RewardsScreen(),
                    // ChatScreen()
                  ],
                ),
              ),
            ));
  }
}
