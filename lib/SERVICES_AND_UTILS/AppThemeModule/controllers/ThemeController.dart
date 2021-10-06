import 'package:MediaPlus/SERVICES_AND_UTILS/AppThemeModule/controllers/Themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

///controls the theme of the app and change it according to the user input
class ThemeController extends GetxController {
  changeTheme(String themeColor) {
    ThemeData theme = getTheme(themeColor);
    Get.changeTheme(theme);
  }

  ThemeData getTheme(String themeColor) {
    switch (themeColor) {
      case "light":
        return Themes.lightTheme;
        break;
      case "dark":
        return Themes.darkTheme;
        break;
      default:
        return Themes.darkTheme;
    }
  }
}
