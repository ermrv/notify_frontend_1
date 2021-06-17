import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class BottomNavbarController extends GetxController {
  int currentIndex = 0;
  double height = 55.0;

  pageController(PageController controller, int value) {
    currentIndex = value;
    controller.jumpToPage(value);
    // controller.animateToPage(value,
    //     duration: Duration(milliseconds: 500), curve: Curves.decelerate);
    update();
  }

  navbarHeightHandler(UserScrollNotification notification) {
    if (notification.metrics.axis == Axis.vertical) {
      if (notification.direction == ScrollDirection.reverse) {
        if (height == 55.0) {
          height = 0.0;

          update();
        }
      } else if (notification.direction == ScrollDirection.forward) {
        if (height == 0.0) {
          height = 55.0;
          update();
        }
      }
    }
  }
}
