import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/controllers/SignupScreenController.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SignupScreen extends StatelessWidget {
  final signupScreenController = Get.put(SignUpScreenController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpScreenController>(
        builder: (controller) => Scaffold(
              extendBodyBehindAppBar: false,
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                elevation: 0.5,
                title: Text(
                  "Welcome to MediaPlus",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 15.0, left: 15.0),
                      child: Text(
                        "Help others find you:",
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    //profile pic
                    Container(
                      margin: EdgeInsets.only(top: screenHeight * 0.05),
                      alignment: Alignment.center,
                      width: screenWidth,
                      child: Stack(
                        overflow: Overflow.visible,
                        children: [
                          Container(
                            height: 150.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, border: Border()),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: controller.profilePic == null
                                  ? Container(
                                      child: Image.asset(
                                        "assets/dummy-profile-pic.png",
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Image.file(
                                      controller.profilePic,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                          Positioned(
                              bottom: -25.0,
                              right: 0.0,
                              child: Container(
                                child: RaisedButton(
                                    elevation: 0.2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                    onPressed: () {
                                      controller.handleFileReturned();
                                    },
                                    child: Text(
                                      "Change",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 50.0, bottom: 10.0),
                      width: screenWidth * 0.9,
                      child: TextFormField(
                        controller: controller.nameEditingController,
                        textCapitalization: TextCapitalization.words,
                        onChanged: (value) {
                          controller.newUserRegName = value;
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: "Name",
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
                      width: screenWidth * 0.9,
                      child: TextFormField(
                        controller: controller.passwordEditingController,
                        onChanged: (value) {
                          controller.newUserRegPassword = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: "Set Password (Optional)",
                        ),
                      ),
                    ),
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        elevation: 0,
                        child: Container(
                          height: 45.0,
                          width: screenWidth * 0.8,
                          alignment: Alignment.center,
                          child: Text(
                            "DONE",
                          ),
                        ),
                        onPressed: () {
                          controller.sendUserData();
                          print("okay");
                        })
                  ],
                ),
              ),
            ));
  }
}
