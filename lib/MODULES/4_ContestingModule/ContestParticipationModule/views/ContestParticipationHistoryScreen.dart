import 'package:MediaPlus/MODULES/4_ContestingModule/ContestParticipationModule/controllers/ContestParticipationHistoryScreenController.dart';
import 'package:MediaPlus/MODULES/4_ContestingModule/ContestParticipationModule/views/ContestParticipationPostUploadScreen.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContestParticipationHistoryScreen extends StatelessWidget {
  final ContestParticipationHistoryScreenController
      contestParticipationHistoryScreenController =
      Get.put(ContestParticipationHistoryScreenController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContestParticipationHistoryScreenController>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                title: Text("Participation History"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Get.to(() => ContestParticipationPostUploadScreen(
                              contestId: "dfdf",
                              contestName: "dfsdfdf",
                            ));
                      },
                      child: Text("post"))
                ],
              ),
              body: ListView(
                children: [
                  for (var i = 0; i < 20; i++)
                    Container(
                      decoration:
                          BoxDecoration(border: Border(bottom: BorderSide())),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Container(
                            height: 60.0,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ///host profile pic
                                Container(
                                  height: 40.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Obx(
                                () => CachedNetworkImage(
                                  imageUrl: PrimaryUserData
                                      .primaryUserData.profilePic.value,
                                  fit: BoxFit.cover,
                                ),
                              ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 2.0),
                                        child: Text(
                                          "Contest Name",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15.0),
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Host Name',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13.0),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                TextButton(
                                    style: ButtonStyle(
                                        padding:
                                            MaterialStateProperty.resolveWith(
                                                (states) =>
                                                    EdgeInsets.symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 15.0))),
                                    child: Row(
                                      children: [
                                        Text("Status: "),
                                        Text(
                                          "Posted",
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      print("object");
                                    }),
                              ],
                            ),
                          ),
                          Container(
                            child: AspectRatio(
                                aspectRatio: 4 / 3,
                                child: Image.asset(
                                  "assets/contests.jpg",
                                  fit: BoxFit.fill,
                                )),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: TextButton(
                                      onPressed: () {
                                        Get.bottomSheet(Container(
                                          height: 400.0,
                                          child: Scaffold(),
                                        ));
                                      },
                                      child: Text("Total Points: 382")),
                                ),
                                Container(
                                  child: TextButton(
                                      onPressed: () {
                                        Get.bottomSheet(Container(
                                          height: 300.0,
                                          child: Scaffold(),
                                        ));
                                      },
                                      child: Text("Contest Details")),
                                ),
                                Container(
                                  child: TextButton(
                                      onPressed: () {
                                        Get.bottomSheet(Container(
                                          height: 400.0,
                                          child: Scaffold(),
                                        ));
                                      },
                                      child: Text("Message")),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                ],
              ),
            ));
  }
}
