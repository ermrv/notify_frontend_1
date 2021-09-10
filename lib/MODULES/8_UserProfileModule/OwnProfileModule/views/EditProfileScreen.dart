import 'dart:ui';

import 'package:MediaPlus/MODULES/8_UserProfileModule/OwnProfileModule/controllers/EditProfileController.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OwnProfileModule/views/ShowProfilePicScreen.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:flutter/material.dart';
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
                  style: TextStyle(color: Colors.black),
                ),
                brightness: Brightness.light,
                backgroundColor: Colors.white,
                elevation: 1.0,
                iconTheme: IconThemeData(color: Colors.black),
              ),
              extendBodyBehindAppBar: true,
              body: ListView(
                children: [
                  Container(
                    height: 10.0,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.0),
                    child: RaisedButton(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Container(
                          height: 45.0,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  height: 40.0,
                                  width: 40.0,
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: Image.network(
                                        PrimaryUserData
                                            .primaryUserData.profilePic,
                                        fit: BoxFit.fill,
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
                    child: RaisedButton(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Container(
                          height: 45.0,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  height: 40.0,
                                  width: 40.0,
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: Image.network(
                                        PrimaryUserData
                                            .primaryUserData.profilePic,
                                        fit: BoxFit.fill,
                                      ))),
                              Text("  Change Cover Pic"),
                            ],
                          ),
                        ),
                        onPressed: () {
                          print("update profile screen");
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
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                          8.0,
                        )),
                        elevation: 0.0,
                        child: Container(
                          height: 45.0,
                          alignment: Alignment.center,
                          child: Text("Done"),
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
