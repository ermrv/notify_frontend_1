import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/UserStatusManagerModule/controllers/StatusDisplayPageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusDisplayPageScreen extends StatelessWidget {
  final controller = Get.put(StatusDisplayPageController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatusDisplayPageController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(),
        body: PageView(
          scrollDirection: Axis.horizontal,
          children: [
            for (var i = 0; i <= 10; i++)
              Container(
                height: screenHeight,
                width: screenWidth,
                child: Stack(
                  children: [
                    //status content contianer
                    Container(),
                    //total number of status hightlighter
                    Positioned(
                      top: 0.0,
                      child: Container(
                        width: screenWidth,
                        height: 3.0,
                        child: Row(
                          children: [
                            for (var i = 0; i <= 3; i++)
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 1.0),
                                height: 1.0,
                                width: screenWidth / 3 - 2.0,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    //write a comment section
                    Positioned(
                        bottom: 5.0,
                        child: Container(
                          height: 50.0,
                          width: screenWidth,
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "write a comment...."),
                          ),
                        )),
                    //user details section
                    Container(),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
