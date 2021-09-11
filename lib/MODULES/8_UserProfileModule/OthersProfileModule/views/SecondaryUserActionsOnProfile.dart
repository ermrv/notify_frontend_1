import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/CommonPostDisplayPageScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondaryUserActionsOnProfile extends StatelessWidget {
  final String profileId;

  const SecondaryUserActionsOnProfile({Key key,@required this.profileId}) : super(key: key);
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
                          alignment: Alignment.center, child: Text("Photos")),
                      onPressed: () {
                        Get.to(() => CommonPostDisplayPageScreen(
                              title: "Photos",
                              apiUrl: ApiUrlsData.otherUserPosts,
                              apiData: {"type":"image","userId":profileId},
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
                              apiUrl: ApiUrlsData.otherUserPosts,
                              apiData: {"type":"video","userId":profileId},
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
