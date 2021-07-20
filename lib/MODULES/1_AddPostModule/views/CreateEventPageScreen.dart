import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/controllers/CreateEventPageScreenController.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateEventPageScreen extends StatelessWidget {
  final CreateEventPageScreenController createContestScreenController =
      Get.put(CreateEventPageScreenController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateEventPageScreenController>(
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
                            controller.postEventHandler();
                          }
                        },
                        child: controller.isUploading
                            ? Text("Posting..")
                            : Text("Post Event")),
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
                        aspectRatio: controller.eventImageAspectRatio < 0.8
                            ? 0.8
                            : controller.eventImageAspectRatio,
                        child: controller.eventImage == null
                            ? GestureDetector(
                                onTap: () {
                                  controller.getEventImage();
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
                                      aspectRatio:
                                          controller.eventImageAspectRatio < 0.8
                                              ? 0.8
                                              : controller
                                                  .eventImageAspectRatio,
                                      child: Image.file(
                                        controller.eventImage,
                                        fit: BoxFit.fitWidth,
                                      )),
                                  Positioned(
                                      bottom: 0.0,
                                      right: 5.0,
                                      child: TextButton(
                                          onPressed: () {
                                            controller.getEventImage();
                                          },
                                          child: Text(" Change ")))
                                ],
                              ),
                      ),
                    ),
                    //contet name
                    Container(
                      width: screenWidth,
                      margin:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: controller.eventNameController,
                        maxLines: 1,
                        decoration: InputDecoration(labelText: "Event Name*"),
                      ),
                    ),
                    //contest description
                    Container(
                      width: screenWidth,
                      margin:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: controller.eventDescriptionController,
                        maxLines: null,
                        decoration:
                            InputDecoration(labelText: "Event Description*"),
                      ),
                    ),
                    //contest start date
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                      width: screenWidth,
                      child: Row(
                        children: [
                          Container(
                            child: Text(
                              "Starts On:",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 15.0),
                              height: 45.0,
                              child: DateTimePicker(
                                controller: controller.eventStartDateController,
                                type: DateTimePickerType.dateTime,
                                dateMask: 'E   d MMMM, yyyy - hh:mm a',
                                use24HourFormat: false,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(Duration(days: 365 * 10)),
                                onChanged: (value) {
                                  controller.eventStartDate =
                                      DateTime.parse(value).toIso8601String();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //event end date
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
                                controller: controller.eventStartDateController,
                                type: DateTimePickerType.dateTime,
                                dateMask: 'E   d MMMM, yyyy - hh:mm a',
                                use24HourFormat: false,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(Duration(days: 365 * 10)),
                                onChanged: (value) {
                                  controller.eventEndDate =
                                      DateTime.parse(value).toIso8601String();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      height: 60.0,
                    )

                    //contest end date
                  ],
                ),
              ),
            ));
  }
}
