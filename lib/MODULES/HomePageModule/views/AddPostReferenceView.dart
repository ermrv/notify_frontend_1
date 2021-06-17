import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/AddPostModule/views/AddPostPageScreen.dart';
import 'package:MediaPlus/MODULES/AddPostModule/views/CreateEventPageScreen.dart';
import 'package:MediaPlus/MODULES/AddPostModule/views/CreatePollPageScreen.dart';
import 'package:MediaPlus/MODULES/ContestingModule/ContestHostingModule/views/CreateContestScreen.dart';
import 'package:MediaPlus/MODULES/UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPostReferenceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AddPostPageScreen());
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.0),
        width: screenWidth,
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).accentColor.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top:1.0, bottom: 1.0, left: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: CachedNetworkImage(
                          imageUrl: PrimaryUserData.primaryUserData.profilePic,
                          fit: BoxFit.cover,
                        )),
                  ),
                  Container(
                    child: Text("  Just, share it........!",style: TextStyle(fontSize: 16.0,color: Theme.of(context).accentColor.withOpacity(0.7)),),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.event),
                    onPressed: () {
                      Get.to(() => CreateEventPageScreen());
                    },
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.poll),
                    onPressed: () {
                      Get.to(() => CreatePollPageScreen());
                    },
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.local_activity),
                    onPressed: () {
                      Get.to(() => CreateContestScreen());
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
