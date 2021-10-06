import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
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
                      return Container(
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 0.5,
                                    color: Theme.of(context)
                                        .secondaryHeaderColor))),
                        child: ListTile(
                          horizontalTitleGap: 3.0,
                           onTap: () {
                            Get.to((OtherUserProfilePageScreen(
                                profileOwnerId: controller.data[index]
                                    ["_id"])));
                          },
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              height: 35.0,
                              width: 35.0,
                              child: CachedNetworkImage(
                                imageUrl: ApiUrlsData.domain +
                                    controller.data[index]["profilePic"],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title:
                              Text(controller.data[index]["name"].toString()),
                          // subtitle: Text(
                          //     controller.data[index]["userName"].toString()),
                          trailing: controller
                              .getFollowButton(controller.data[index]["_id"]),
                        ),
                      );
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
