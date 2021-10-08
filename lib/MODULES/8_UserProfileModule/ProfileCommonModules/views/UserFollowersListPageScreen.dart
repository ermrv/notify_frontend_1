import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ReferenceRelatedViews/ProfileReferenceRelated/HorizontalProfileReferenceTemplate.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OthersProfileModule/views/OtherUserProfilePageScreen.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/ProfileCommonModules/controllers/UserFollowersListPageController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

/// stlful widget--Listview which contains all the list of Followings
class UserFollowersListPageScreen extends StatelessWidget {
  final String userId;

  UserFollowersListPageScreen({Key key, @required this.userId})
      : super(key: key);

  final controller = Get.put(UserFollowersListPageController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserFollowersListPageController>(
      initState: (state) {
        controller.profileId = userId;
        controller.initialise();
      },
      builder: (controller) => Scaffold(
        appBar: AppBar(
          elevation: 0.2,
          title: Text(
            "Followers",
          ),
        ),
        body: controller.requestProcessed
            ? controller.data.length == 0
                ? Center(
                    heightFactor: 5.0,
                    child: Text("No Followings!"),
                  )
                : ListView.builder(
                    itemCount: controller.data.length,
                    itemBuilder: (context, index) {
                      return HorizontalProfileReferenceTemplate(
                          userData: controller.data[index]);
                    },
                  )
            : Center(
                child: SpinKitThreeBounce(
                  size: 22.0,
                  color: Colors.blue,
                ),
              ),
      ),
    );
  }
}
