import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/4_ContestingModule/ContestHostingModule/views/ContestHostingHistoryScreen.dart';
import 'package:MediaPlus/MODULES/4_ContestingModule/ContestParticipationModule/views/ContestParticipationHistoryScreen.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/8_UserProfileModule/views/UserProfileScreen.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/views/LoginScreen.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserDrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.6,
      decoration: BoxDecoration(
          color: Theme.of(context).appBarTheme.backgroundColor,
          border: Border(right: BorderSide())),
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Theme.of(context).accentColor, width: 1.0)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: CachedNetworkImage(
                      imageUrl: PrimaryUserData.primaryUserData.profilePic,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Text(
                    PrimaryUserData.primaryUserData.name,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 21.0),
                  ),
                )
              ],
            ),
          ),
          body: Column(
            children: [
              Container(
                // decoration: BoxDecoration(border: Border(bottom: BorderSide())),
                margin: EdgeInsets.only(left: 8.0, right: 18.0),
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.resolveWith((states) =>
                          EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0))),
                  onPressed: () {
                    Get.to(() => UserProfileScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Full Profile",
                      ),
                      Text(">>>")
                    ],
                  ),
                ),
              ),
              // Container(
              //   height: 150.0,
              //   child: Column(
              //     children: [
              //       Container(
              //         alignment: Alignment.centerLeft,
              //         margin:
              //             EdgeInsets.symmetric(horizontal: 3.0, vertical: 5.0),
              //         child: Text("Contest:"),
              //       ),
              //       Container(
              //           margin: EdgeInsets.symmetric(horizontal: 18.0),
              //           padding: EdgeInsets.symmetric(vertical: 5.0),
              //           child: TextButton(
              //               style: ButtonStyle(
              //                   padding: MaterialStateProperty.resolveWith(
              //                       (states) => EdgeInsets.symmetric(
              //                           horizontal: 10.0, vertical: 10.0))),
              //               onPressed: () {
              //                 Get.to(() => ContestParticipationHistoryScreen());
              //               },
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Text("Contest Participation"),
              //                   Text(">>>")
              //                 ],
              //               ))),
              //       Container(
              //           margin: EdgeInsets.symmetric(horizontal: 18.0),
              //           padding: EdgeInsets.symmetric(vertical: 5.0),
              //           child: TextButton(
              //               style: ButtonStyle(
              //                   padding: MaterialStateProperty.resolveWith(
              //                       (states) => EdgeInsets.symmetric(
              //                           horizontal: 10.0, vertical: 10.0))),
              //               onPressed: () {
              //                 Get.to(() => ContestHostingHistoryScreen());
              //               },
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [Text("Contest Hosting"), Text(">>>")],
              //               ))),
              //     ],
              //   ),
              // ),
              Expanded(child: Container()),
              Container(
                  margin: EdgeInsets.only(left: 8.0, right: 18.0),
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: TextButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.resolveWith((states) =>
                              EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0))),
                      onPressed: () async {
                        var response = await ApiServices.postWithAuth(
                            ApiUrlsData.domain + "/api/notification",
                            {},
                            userToken);
                        print(response);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("Get notifications"), Text(">>>")],
                      ))),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                height: 1.0,
                color: Theme.of(context).accentColor.withOpacity(0.3),
              ),
              Container(
                  margin: EdgeInsets.only(left: 8.0, right: 18.0),
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: TextButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.resolveWith((states) =>
                              EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0))),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("Settings"), Text(">>>")],
                      ))),
              // Container(
              //     margin: EdgeInsets.symmetric(horizontal: 8.0),
              //     padding: EdgeInsets.symmetric(vertical: 5.0),
              //     child: TextButton(
              //         style: ButtonStyle(
              //             padding: MaterialStateProperty.resolveWith((states) =>
              //                 EdgeInsets.symmetric(
              //                     horizontal: 10.0, vertical: 10.0))),
              //         onPressed: () {},
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [Text("Change Theme"), Text(">>>")],
              //         ))),
              Container(
                margin: EdgeInsets.only(left: 8.0, right: 18.0),
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.resolveWith((states) =>
                            EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0))),
                    onPressed: () async {
                      final storage = GetStorage();
                      userToken = "";
                      await storage
                          .remove("userToken")
                          .then((value) => Get.offAll(() => LoginScreen()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("LogOut"),
                        Icon(Icons.power_settings_new)
                      ],
                    )),
              ),
            ],
          )),
    );
  }
}
