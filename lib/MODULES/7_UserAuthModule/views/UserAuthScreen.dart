import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/controllers/UserAuthScreenController.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/views/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

///starting point of user auth module
class UserAuthScreen extends StatelessWidget {
  final userAuthScreenController = Get.put(UserAuthScreenController());
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return GetBuilder<UserAuthScreenController>(
      builder: (controller) => Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Center(
            child: SpinKitThreeBounce(
          color: Colors.blue,
          size: 22.0,
        )),
      ),
    );
  }
}
