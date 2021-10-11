import 'dart:convert';
import 'dart:io';

import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/LocalDataFiles.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class PrimaryUserData {
  ///defaulst userId generated by db
  String userId;
  List followers = [];
  List followings = [];
  List blockedUsers = [];
  var name = "".obs;
  String userName;
  String mobile;
  var bio="".obs;

  ///complete address of profile pic
  var profilePic = "".obs;

  ///complete address of cover pic
  var coverPic = "".obs;
  String email;

  jsonToModel(var jsonData) {
    this.userId = jsonData["userdata"]["_id"];
    followers.addAll(jsonData["userdata"]["followers"]);
    followings.addAll(jsonData["userdata"]["following"]);
    blockedUsers.addAll(jsonData["userdata"]["blocked"]);
    this.name.value = jsonData["userdata"]["name"];
    this.userName = jsonData["userdata"]["username"];
    this.mobile = jsonData["userdata"]["mobile"];
    this.bio = jsonData["userdata"]["bio"];
    this.profilePic.value =
        ApiUrlsData.domain + jsonData["userdata"]["profilePic"];
    this.coverPic.value = ApiUrlsData.domain + jsonData["userdata"]["coverPic"];
    this.email = jsonData["userdata"]["email"];
  }

  static final PrimaryUserData primaryUserData = PrimaryUserData();

  ///set the userName of the user
  void setUserName(String userName) async {
    this.userName = userName;
    deleteLocalUserBasicDataFile();
  }

  ///set name of the user
  void setName(String name) async {
    this.name.value = name;
    deleteLocalUserBasicDataFile();
  }

  ///set bio of the user
  void setBio(var bio) async {
    this.bio = bio;
    deleteLocalUserBasicDataFile();
  }

  ///set profile pic of the user
  setProfilePic(String profilePic) async {
    this.profilePic.value = ApiUrlsData.domain + profilePic;
    deleteLocalUserBasicDataFile();
  }

  ///set cover pic of the user
  setCoverPic(String coverPic) async {
    this.coverPic.value = ApiUrlsData.domain + coverPic;
    deleteLocalUserBasicDataFile();
  }

  ///deleting the local file in case of profile data edited by the user
  ///
  deleteLocalUserBasicDataFile() async {
    try {
      await File(LocalDataFiles.userBasicDataFilePath).delete(recursive: true);
    } catch (e) {
      print("error");
    }
  }
}
