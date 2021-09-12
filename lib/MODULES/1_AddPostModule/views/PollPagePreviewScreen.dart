import 'package:MediaPlus/MODULES/1_AddPostModule/controllers/CreatePollPageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PollPagePreviewScreen extends StatefulWidget {
  @override
  _PollPagePreviewScreenState createState() => _PollPagePreviewScreenState();
}

class _PollPagePreviewScreenState extends State<PollPagePreviewScreen> {
  final controller = Get.find<CreatePollPageController>();

  String _vote;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreatePollPageController>(
      builder: (controller) => Scaffold(
        bottomNavigationBar: Container(
          height: 50.0,
          alignment: Alignment.center,
          child: TextButton(
            child: Container(
              height: 50.0,
              alignment: Alignment.center,
              child: controller.isUploading ? Text("posting...") : Text("Post"),
            ),
            onPressed: () {
              if (!controller.isUploading) {
                controller.uploadPollPost();
              }
            },
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text("Preview"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                      child: Text(
                        controller.title,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    for (var i in controller.options)
                      i == ""
                          ? Container()
                          : Container(
                              height: 45.0,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 19.0, vertical: 3.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    _vote = i;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Radio(
                                        value: i,
                                        toggleable: true,
                                        groupValue: _vote,
                                        onChanged: (value) {
                                          print(value);
                                          setState(() {
                                            _vote = value;
                                          });
                                        }),
                                    Text(
                                      i,
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                  ],
                                ),
                              ))
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
