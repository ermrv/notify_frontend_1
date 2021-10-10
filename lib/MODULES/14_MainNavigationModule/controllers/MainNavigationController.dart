import 'package:MediaPlus/MODULES/17_ShortVideoPlayerModule/views/ShortVideoPlayerPageScreen.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/AddPostPageScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MainNavigationController extends GetxController {
  double height = 60.0;
  PageController pageController;
  int currentIndex = 0;
  bool hidden = false;

  @override
  void onInit() {
    pageController = PageController(initialPage: currentIndex);
    

    super.onInit();
  }

  pageTransitionHandler(int index) {
    print(index);
    if (index == 2) {
      Get.to(() => ShortVideoPlayerPageScreen());
    } else {
      pageController.jumpToPage(
        index,
      );
      currentIndex = index;
    }

    update();
  }


  //hide the bottom nav bar when scrolling upward
  //
  // bottomNavigationbarViewHandler(UserScrollNotification notification) {
  //   if (!hidden) {
  //     print(hidden.toString());
  //     if (notification.metrics.axis == Axis.vertical &&
  //         notification.direction == ScrollDirection.reverse) {
  //       height = 0.0;
  //       update();
  //     } else if (notification.metrics.axis == Axis.vertical &&
  //         notification.direction == ScrollDirection.forward) {
  //       if (height == 0) {
  //         height = 60.0;
  //         update();
  //       }
  //     }
  //     print("scrolled");
  //   }
  // }

  //hide
  //
  hide() {
    if (height == 60) {
      height = 0.0;
      hidden = true;
      update();
    }
  }

  //restoring height of bottom nav bar
  //
  show() {
    if (height == 0) {
      height = 60.0;
      hidden = false;
      update();
    }
  }
}
