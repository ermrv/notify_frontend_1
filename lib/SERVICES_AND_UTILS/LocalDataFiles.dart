import 'dart:io';

import 'package:path_provider/path_provider.dart';

abstract class LocalDataFiles {
  static String newsFeedPostsDataFilePath;
  static String userBasicDataFilePath;
  static String profilePostsDataFilePath;
  static String explorePageDataFilePath;
  static String notificationPageDataFilePath;
  ///refreshing page status
  ///if true local file will be updated with new data from server
  static bool refreshNewsFeedFile = false;
  static bool refreshProfilePostsFile = false;

  static initialiseLocalFilesPath() async {
    final directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    newsFeedPostsDataFilePath = "$path/newsFeedPostsDataFile.json";
    userBasicDataFilePath = "$path/userBasicDataFile.json";
    profilePostsDataFilePath = "$path/userProfilePostsDataFile.json";
    explorePageDataFilePath = "$path/explorePageDataFilePath.json";
    notificationPageDataFilePath = "$path/notificationPageDataFilePath.json";
  }

  static setRefreshNewsFeedFile(bool status) {
    refreshNewsFeedFile = status;
  }

  static setRefreshProfilePostsFile(bool status) {
    refreshProfilePostsFile = status;
  }
}
