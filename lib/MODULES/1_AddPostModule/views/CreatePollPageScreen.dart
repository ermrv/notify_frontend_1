import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/controllers/CreatePollPageController.dart';
import 'package:MediaPlus/MODULES/1_AddPostModule/views/PollPagePreviewScreen.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePollPageScreen extends StatelessWidget {
  final createPollPageController = Get.put(CreatePollPageController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreatePollPageController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text("Create a poll"),
          actions: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0),
              height: 30.0,
              alignment: Alignment.center,
              child: TextButton(
                child: Container(
                  height: 21.0,
                  alignment: Alignment.center,
                  child: Text("Preview"),
                ),
                onPressed: () {
                  controller.handlePreview();
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Poll Title:",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10.0),
                      width: screenWidth,
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: controller.titleController,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: "Add a title eg:a question?",
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //contest end date
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
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
                          controller: controller.pollEndDateController,
                          type: DateTimePickerType.dateTime,
                          dateMask: 'E   d MMMM, yyyy - hh:mm a',
                          use24HourFormat: false,
                          firstDate: DateTime.now().subtract(Duration(days: 1)),
                          lastDate:
                              DateTime.now().add(Duration(days: 365 * 10)),
                          onChanged: (value) {
                            controller.pollEndDate =
                                DateTime.parse(value).toIso8601String();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10.0),
                      width: screenWidth,
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: controller.option1Controller,
                        maxLines: null,
                        decoration: InputDecoration(
                            labelText: "Option One **",
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(width: 0.5)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.7,
                                    color: Theme.of(context).accentColor)),
                            prefix: Text("1.")),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10.0),
                      width: screenWidth,
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: controller.option2Controller,
                        maxLines: null,
                        decoration: InputDecoration(
                            labelText: "Option Two **",
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(width: 0.5)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.7,
                                    color: Theme.of(context).accentColor)),
                            prefix: Text("2.")),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10.0),
                      width: screenWidth,
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: controller.option3Controller,
                        maxLines: null,
                        decoration: InputDecoration(
                            labelText: "Option Three",
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(width: 0.5)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.7,
                                    color: Theme.of(context).accentColor)),
                            prefix: Text("3.")),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10.0),
                      width: screenWidth,
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: controller.option4Controller,
                        maxLines: null,
                        decoration: InputDecoration(
                            labelText: "Option Four",
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(width: 0.5)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.7,
                                    color: Theme.of(context).accentColor)),
                            prefix: Text("4.")),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
