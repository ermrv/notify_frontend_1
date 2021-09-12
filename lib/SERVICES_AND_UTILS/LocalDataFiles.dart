import 'dart:io';

import 'package:path_provider/path_provider.dart';

abstract class LocalDataFiles {
  static String newsFeedPostsDataFilePath;
  static String userBasicDataFilePath;
  static String profilePostsDataFilePath;

  static initialiseLocalFilesPath() async {
    final directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    newsFeedPostsDataFilePath = "$path/newsFeedPostsDataFile.json";
    userBasicDataFilePath = "$path/userBasicDataFile.json";
    profilePostsDataFilePath = "$path/userProfilePostsDataFile";
  }
}
