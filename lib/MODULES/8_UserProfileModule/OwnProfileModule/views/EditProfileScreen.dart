import 'dart:ui';

import 'package:MediaPlus/MODULES/8_UserProfileModule/OwnProfileModule/controllers/EditProfileController.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OwnProfileModule/controllers/ShowCoverPicScreenController.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OwnProfileModule/views/ShowCoverPicScreen.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OwnProfileModule/views/ShowProfilePicScreen.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final editProfileController = Get.put(EditProfileController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                title: Text(
                  "Edit Profile",
                ),
              ),
              extendBodyBehindAppBar: true,
              body: ListView(
                children: [
                  Container(
                    height: 10.0,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextButton(
                        child: Container(
                          height: 40.0,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  height: 35.0,
                                  width: 35.0,
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: CachedNetworkImage(
                                        imageUrl: PrimaryUserData
                                            .primaryUserData.profilePic,
                                        fit: BoxFit.cover,
                                      ))),
                              Text("  Change Profile Pic"),
                            ],
                          ),
                        ),
                        onPressed: () {
                          Get.to(() => ShowProfilePicScreen());
                        }),
                  ),
                  Container(
                    height: 20.0,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextButton(
                        child: Container(
                          height: 40.0,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  height: 35.0,
                                  width: 35.0,
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: CachedNetworkImage(
                                        imageUrl: PrimaryUserData
                                            .primaryUserData.coverPic,
                                        fit: BoxFit.cover,
                                      ))),
                              Text("  Change Cover Pic"),
                            ],
                          ),
                        ),
                        onPressed: () {
                          Get.to(() => ShowCoverPicScreen());
                        }),
                  ),
                  Container(
                    height: 20.0,
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Username:"),
                        ),
                        Container(
                          child: TextFormField(
                            controller: controller.userNameIdEdititngController,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Name:"),
                        ),
                        Container(
                          child: TextFormField(
                            controller: controller.nameEditingController,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Bio:"),
                        ),
                        Container(
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 2,
                            controller: controller.bioEditingController,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                    child: TextButton(
                        child: Container(
                          height: 35.0,
                          alignment: Alignment.center,
                          child: controller.isUpdating
                              ? SpinKitThreeBounce(
                                  color: Colors.blue,
                                  size: 18.0,
                                )
                              : Text("Done"),
                        ),
                        onPressed: () {
                          controller.sendEditedData();
                        }),
                  )
                ],
              ),
            ));
  }
}
