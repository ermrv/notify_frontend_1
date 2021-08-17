import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/CommonPostDisplayPageScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondaryUserActionsOnProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.0, bottom: 4.0),
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 25.0,
            width: screenWidth * 0.9,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                      child: Container(
                          alignment: Alignment.center,
                          child: Text("Follow")),
                      onPressed: () {
                        
                      }),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                      child: Container(
                          alignment: Alignment.center,
                          child: Text("Photos")),
                      onPressed: () {
                        Get.to(() => CommonPostDisplayPageScreen(
                              title: "Photos",
                            ));
                      }),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                      child: Container(
                          alignment: Alignment.center, child: Text("Photos")),
                      onPressed: () {
                        Get.to(() => CommonPostDisplayPageScreen(
                              title: "Photos",
                            ));
                      }),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                      child: Container(
                          alignment: Alignment.center, child: Text("Videos")),
                      onPressed: () {
                        Get.to(() => CommonPostDisplayPageScreen(
                              title: "Videos",
                            ));
                      }),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                      child: Container(
                          alignment: Alignment.center, child: Text("Events")),
                      onPressed: () {
                        Get.to(() => CommonPostDisplayPageScreen(
                              title: "Events",
                            ));
                      }),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                      child: Container(
                          alignment: Alignment.center, child: Text("Contests")),
                      onPressed: () {
                        Get.to(() => CommonPostDisplayPageScreen(
                              title: "Contests",
                            ));
                      }),
                ),
              ],
            ),
          ),

          ///to navigate to the grid view of the psots
          Icon(Icons.keyboard_arrow_right)
        ],
      ),
    );
  }
}
