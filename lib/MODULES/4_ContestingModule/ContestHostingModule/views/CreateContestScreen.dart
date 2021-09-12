import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/4_ContestingModule/ContestHostingModule/controllers/CreateContestScreenController.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateContestScreen extends StatelessWidget {
  final CreateContestScreenController createContestScreenController =
      Get.put(CreateContestScreenController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateContestScreenController>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text("Create Contest"),
                actions: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                    child: TextButton(
                        onPressed: () {
                          if (!controller.isUploading) {
                            controller.postContestHandler();
                          }
                        },
                        child: controller.isUploading
                            ? Text("Posting..")
                            : Text("Post Contest")),
                  )
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    //contsets image poster
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all()),
                      child: AspectRatio(
                        aspectRatio: controller.contestImageAspectRatio < 0.8
                            ? 0.8
                            : controller.contestImageAspectRatio,
                        child: controller.contestImage == null
                            ? GestureDetector(
                                onTap: () {
                                  controller.getContestImage();
                                },
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_a_photo,
                                        size: 40.0,
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(top: 8.0),
                                          child:
                                              Text("Add contest Image/Poster"))
                                    ],
                                  ),
                                ))
                            : Stack(
                                children: [
                                  AspectRatio(
                                      aspectRatio: controller
                                                  .contestImageAspectRatio <
                                              0.8
                                          ? 0.8
                                          : controller.contestImageAspectRatio,
                                      child: Image.file(
                                        controller.contestImage,
                                        fit: BoxFit.fitWidth,
                                      )),
                                  Positioned(
                                      bottom: 0.0,
                                      right: 5.0,
                                      child: TextButton(
                                          onPressed: () {
                                            controller.getContestImage();
                                          },
                                          child: Text(" Change ")))
                                ],
                              ),
                      ),
                    ),
                    //total prize coins
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: TextButton(
                          onPressed: () {
                            controller.getPrizeCoins();
                          },
                          child: Container(
                            height: 30.0,
                            alignment: Alignment.center,
                            child: Text("Set Prize Coins"),
                          )),
                    ),
                    //contet name
                    Container(
                      width: screenWidth,
                      margin:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                      child: TextFormField(
                        controller: controller.contestNameController,
                        maxLines: 1,
                        decoration: InputDecoration(labelText: "Contest Name*"),
                      ),
                    ),

                    //contest end date
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                      width: screenWidth,
                      child: Row(
                        children: [
                          Container(
                            child: Text(
                              "Ends On:",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 15.0),
                              height: 45.0,
                              child: DateTimePicker(
                                controller: controller.contestEndDateController,
                                type: DateTimePickerType.dateTime,
                                dateMask: 'E   d MMMM, yyyy - hh:mm a',
                                use24HourFormat: false,
                                firstDate:
                                    DateTime.now().add(Duration(days: 1)),
                                lastDate: DateTime.now()
                                    .add(Duration(days: 365 * 10)),
                                onChanged: (value) {
                                  controller.contestEndDate =
                                      DateTime.parse(value).toIso8601String();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //contest description
                    Container(
                      width: screenWidth,
                      margin:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                      child: TextFormField(
                        controller: controller.contestDescriptionController,
                        maxLines: null,
                        decoration:
                            InputDecoration(labelText: "Contest Description*"),
                      ),
                    ),
                    //contest rules
                    Container(
                      width: screenWidth,
                      margin:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                      child: TextFormField(
                        controller: controller.contestRulesController,
                        maxLines: null,
                        decoration:
                            InputDecoration(labelText: "Contest Rules*"),
                      ),
                    ),

                    //contest end date
                  ],
                ),
              ),
            ));
  }
}
