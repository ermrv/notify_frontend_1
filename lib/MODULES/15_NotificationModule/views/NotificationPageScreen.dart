import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/13_SearchEngineModule/views/SearchInputPageScreen.dart';
import 'package:MediaPlus/MODULES/15_NotificationModule/controllers/NotificationPageController.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/SpecificPostRelated/views/SpecificPostDisplayPageScreen.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/OthersProfileModule/views/OtherUserProfilePageScreen.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/TimeStampProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class NotificationPageScreen extends StatelessWidget {
  final controller = Get.put(NotificationPageController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationPageController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Notifications"),
          actions: [
            IconButton(
                icon: Icon(
                  Feather.search,
                  size: 22.0,
                ),
                onPressed: () {
                  Get.to(() => SearchInputPageScreen());
                }),
            Container(
              width: 3.0,
            )
          ],
        ),
        body: controller.notificationsData == null
            ? Center(
                heightFactor: 5.0,
                child: SpinKitThreeBounce(
                  color: Colors.blue,
                  size: 18.0,
                ),
              )
            : ListView(
                children: [
                  for (var notification in controller.notificationsData)
                    getNotificationTemaplate(notification),
                ],
              ),
      ),
    );
  }

  Container getNotificationTemaplate(var notificationData) {
    switch (notificationData["notificationType"].toString().toLowerCase()) {
      case "like":
        return Container(
          child: GestureDetector(
            onTap: () {
              Get.to(() => SpecificPostDisplayPageScreen(
                  postId: notificationData["postId"]));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                        height: 35.0,
                        width: 35.0,
                        child: CachedNetworkImage(
                          imageUrl: ApiUrlsData.domain +
                              notificationData["user"]["profilePic"].toString(),
                          fit: BoxFit.cover,
                        )),
                  ),
                  Container(
                    width: 4.0,
                  ),
                  Expanded(
                      child: Container(
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: notificationData["notificationString"],
                          style: TextStyle(fontSize: 15.0)),
                      TextSpan(text: "  - "),
                      TextSpan(
                          text: TimeStampProvider.timeStampProvider(
                                  notificationData["createdAt"])
                              .toString(),
                          style: TextStyle(
                              fontSize: 10.0, fontWeight: FontWeight.w700))
                    ])),
                  )),
                ],
              ),
            ),
          ),
        );
        break;
      case "comment":
        return Container(
          child: GestureDetector(
            onTap: () {
              Get.to(() => SpecificPostDisplayPageScreen(
                  postId: notificationData["postId"]));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                        height: 35.0,
                        width: 35.0,
                        child: CachedNetworkImage(
                          imageUrl: ApiUrlsData.domain +
                              notificationData["user"]["profilePic"].toString(),
                          fit: BoxFit.cover,
                        )),
                  ),
                  Container(
                    width: 4.0,
                  ),
                  Expanded(
                    child: Container(
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: notificationData["notificationString"],
                            style: TextStyle(fontSize: 15.0)),
                        TextSpan(text: "  - "),
                        TextSpan(
                            text: TimeStampProvider.timeStampProvider(
                                    notificationData["createdAt"])
                                .toString(),
                            style: TextStyle(
                                fontSize: 10.0, fontWeight: FontWeight.w700))
                      ])),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        break;
      case "follow":
        return Container(
          child: GestureDetector(
            onTap: () {
              Get.to(() => OtherUserProfilePageScreen(
                  profileOwnerId: notificationData["user"]["_id"].toString()));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                        height: 35.0,
                        width: 35.0,
                        child: CachedNetworkImage(
                          imageUrl: ApiUrlsData.domain +
                              notificationData["user"]["profilePic"].toString(),
                          fit: BoxFit.cover,
                        )),
                  ),
                  Container(
                    width: 4.0,
                  ),
                  Expanded(
                      child: Container(
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: notificationData["notificationString"],
                          style: TextStyle(fontSize: 15.0)),
                      TextSpan(text: "  - "),
                      TextSpan(
                          text: TimeStampProvider.timeStampProvider(
                                  notificationData["createdAt"])
                              .toString(),
                          style: TextStyle(
                              fontSize: 10.0, fontWeight: FontWeight.w700))
                    ])),
                  )),
                  notificationData["user"]["_id"].toString() ==
                          PrimaryUserData.primaryUserData.userId
                      ? Container()
                      : Container(
                          child: controller.getFollowButton(
                              notificationData["user"]["_id"].toString(),
                              false),
                        )
                ],
              ),
            ),
          ),
        );
        break;
      default:
        return Container();
    }
  }
}
