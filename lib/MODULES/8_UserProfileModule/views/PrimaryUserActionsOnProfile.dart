import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/views/EditProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrimaryUserActionsOnProfile extends StatelessWidget {
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
                          child: Text("Edit Profile")),
                      onPressed: () {
                        Get.to(EditProfileScreen());
                      }),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                      child: Container(
                          alignment: Alignment.center,
                          child: Text("Promotions")),
                      onPressed: () {
                        print("Promotions");
                      }),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                      child: Container(
                          alignment: Alignment.center, child: Text("Photos")),
                      onPressed: () {
                        print("Promotions");
                      }),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                      child: Container(
                          alignment: Alignment.center, child: Text("Videos")),
                      onPressed: () {
                        print("Promotions");
                      }),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                      child: Container(
                          alignment: Alignment.center, child: Text("Events")),
                      onPressed: () {
                        print("Promotions");
                      }),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                      child: Container(
                          alignment: Alignment.center, child: Text("Contests")),
                      onPressed: () {
                        print("Promotions");
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
