import 'dart:io';

import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/16_SettingsModule/SettingsPageScreen.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/views/UserAuthScreen.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/UserProfileScreen.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/views/LoginScreen.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/AppThemeModule/controllers/ThemeController.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ChangeProfileType.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/LocalDataFiles.dart';
import 'package:MediaPlus/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserDrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Get.back();
              },
            ),
            Container(
              width: 10.0,
            )
          ],
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Theme.of(context).accentColor, width: 1.0)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Obx(
                      () => CachedNetworkImage(
                        imageUrl:
                            PrimaryUserData.primaryUserData.profilePic.value,
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Obx(
                  () => Text(
                    PrimaryUserData.primaryUserData.name.value.toString(),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                ),
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              // decoration: BoxDecoration(border: Border(bottom: BorderSide())),
              margin: EdgeInsets.only(left: 8.0, right: 18.0),
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: TextButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.resolveWith((states) =>
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0))),
                onPressed: () {
                  Get.dialog(ChangeProfileType());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text(
                        "${PrimaryUserData.primaryUserData.profileType.value.toString().capitalizeFirst} Account",
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.dialog(ChangeProfileType());
                        },
                        child: Text("Change")),
                  ],
                ),
              ),
            ),
            Expanded(child: Container()),
            // Container(
            //   margin: EdgeInsets.only(left: 8.0, right: 18.0),
            //   padding: EdgeInsets.symmetric(vertical: 5.0),
            //   child: TextButton(
            //       style: ButtonStyle(
            //           padding: MaterialStateProperty.resolveWith((states) =>
            //               EdgeInsets.symmetric(
            //                   horizontal: 10.0, vertical: 10.0))),
            //       onPressed: () {
            //         ThemeController().changeTheme("light");
            //       },
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("Change Theme"),
            //         ],
            //       )),
            // ),
            // Container(
            //     margin: EdgeInsets.only(left: 8.0, right: 18.0),
            //     padding: EdgeInsets.symmetric(vertical: 5.0),
            //     child: TextButton(
            //         style: ButtonStyle(
            //             padding: MaterialStateProperty.resolveWith((states) =>
            //                 EdgeInsets.symmetric(
            //                     horizontal: 10.0, vertical: 10.0))),
            //         onPressed: () async {
            //           var response = await ApiServices.postWithAuth(
            //               ApiUrlsData.domain + "/api/notification",
            //               {},
            //               userToken);
            //           print(response);
            //         },
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [Text("Get notifications"), Text(">>>")],
            //         ))),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              height: 1.0,
              color: Theme.of(context).accentColor.withOpacity(0.3),
            ),
            Container(
                margin: EdgeInsets.only(left: 8.0, right: 18.0),
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.resolveWith((states) =>
                            EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0))),
                    onPressed: () {
                      Get.off(() => SettingsPageScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Settings"), Text(">>>")],
                    ))),
            // Container(
            //     margin: EdgeInsets.symmetric(horizontal: 8.0),
            //     padding: EdgeInsets.symmetric(vertical: 5.0),
            //     child: TextButton(
            //         style: ButtonStyle(
            //             padding: MaterialStateProperty.resolveWith((states) =>
            //                 EdgeInsets.symmetric(
            //                     horizontal: 10.0, vertical: 10.0))),
            //         onPressed: () {},
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [Text("Change Theme"), Text(">>>")],
            //         ))),
            Container(
              margin: EdgeInsets.only(left: 8.0, right: 18.0),
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.resolveWith((states) =>
                          EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0))),
                  onPressed: () {
                    Get.dialog(AlertDialog(
                      title: Text("Are you sure to LogOut?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("No")),
                        TextButton(
                            onPressed: () {
                              _logOut();
                            },
                            child: Text(
                              "Yes",
                              style: TextStyle(color: Colors.red),
                            )),
                      ],
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("LogOut"), Icon(Icons.power_settings_new)],
                  )),
            ),
          ],
        ));
  }

  _logOut() async {
    final storage = GetStorage();
    userToken = "";
    await _deleteFileSystem().then((value) async {
      if (value) {
        try {
          await storage.remove("userToken");
          await storage.remove("unRegisteredUserToken");
          Get.back();
          Get.offAll(() => LoginScreen());
        } catch (e) {
          print(e);
        }
      } else {
        Get.snackbar("Cannot process request", "Please try again");
      }
    });
  }

  Future<bool> _deleteFileSystem() async {
    bool _isFilesDeleted = false;
    //delete the user basic data file
    try {
      await File(LocalDataFiles.userBasicDataFilePath).delete();
      _isFilesDeleted = true;
    } on FileSystemException {
      _isFilesDeleted = true;
    } catch (e) {
      Get.snackbar("cannot delete files", "try again");
      return false;
    }
    //delete the user newsFeeddatafile
    try {
      await File(LocalDataFiles.newsFeedPostsDataFilePath).delete();
    } on FileSystemException {
      _isFilesDeleted = true;
    } catch (e) {
      Get.snackbar("cannot delete files", "try again");
      return false;
    }
    //deleter the user profileposts data file
    try {
      await File(LocalDataFiles.profilePostsDataFilePath).delete();
    } on FileSystemException {
      _isFilesDeleted = true;
    } catch (e) {
      Get.snackbar("cannot delete files", "try again");
      return false;
    }
    //delete the user notification page data file
    try {
      await File(LocalDataFiles.notificationPageDataFilePath).delete();
    } on FileSystemException {
      _isFilesDeleted = true;
    } catch (e) {
      Get.snackbar("cannot delete files", "try again");
      return false;
    }
    //delete the user explore page data file
    try {
      await File(LocalDataFiles.explorePageDataFilePath).delete();
    } on FileSystemException {
      _isFilesDeleted = true;
    } catch (e) {
      Get.snackbar("cannot delete files", "try again");
      return false;
    }

    return _isFilesDeleted;
  }
}
