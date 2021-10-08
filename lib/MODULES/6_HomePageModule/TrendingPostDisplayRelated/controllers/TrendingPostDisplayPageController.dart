import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TrendingPostDisplayPageController extends GetxController {
  int initialIndex;
  PageController pageController;

  void initialise() {
    pageController = PageController(initialPage: initialIndex);
  }
}
