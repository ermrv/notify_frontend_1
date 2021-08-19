import 'dart:ui';

import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/10_PostPromotionModule/controllers/PromotedPostActionSelectorController.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class PromotedPostActionSelectorPage extends StatelessWidget {
  final String postId;
  final int totalAudience;
  final int duration;
  final int budget;
  final _controller = Get.put(PromotedPostActionSelectorController());

  PromotedPostActionSelectorPage(
      {Key key,
      @required this.postId,
      @required this.totalAudience,
      @required this.duration,
      @required this.budget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PromotedPostActionSelectorController>(
      initState: (state) {
        _controller.postId = postId;
        _controller.totalAudience = totalAudience;
        _controller.duration = duration;
        _controller.budget = budget;

        _controller.textEditingController = TextEditingController();
      },
      builder: (controller) => Scaffold(
        bottomNavigationBar: Container(
          height: 40.0,
          child: TextButton(
            onPressed: () {
             if(!controller.isProcessing)
              controller.sendData();
            },
            child: Container(
                height: 40.0,
                alignment: Alignment.center,
                child:controller.isProcessing?SpinKitThreeBounce(color:Colors.blue,size: 18.0,): Text("Pay Rs. " + controller.budget.toString())),
          ),
        ),
        appBar: AppBar(
          title: Text("Select Action"),
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              child: Text(
                "Total Audience: " + controller.totalAudience.toString(),
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              child: Text(
                "Duration: " + controller.duration.toString() + " Hrs",
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              child: Text(
                "Budget: Rs." + controller.budget.toString(),
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              height: 1.0,
              width: screenWidth,
              color: Theme.of(context).accentColor.withOpacity(0.6),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Action:",
                    style: TextStyle(fontSize: 15.0),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    child: TextButton(
                      onPressed: () {
                        controller.setRedirectionType("profile");
                        controller.redirectionUrl =
                            PrimaryUserData.primaryUserData.userId;
                      },
                      child: Container(
                        height: 35.0,
                        child: Row(
                          children: [
                            Radio(
                                value: "profile",
                                toggleable: true,
                                groupValue: controller.redirectionType
                                    .toLowerCase()
                                    .toString(),
                                onChanged: (value) {
                                  print(value);
                                  controller.setRedirectionType(value);
                                }),
                            Text(
                              "Redirect to Profile",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.9)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    child: TextButton(
                      onPressed: () {
                        controller.setRedirectionType("link");
                      },
                      child: Container(
                        height: 35.0,
                        child: Row(
                          children: [
                            Radio(
                                value: "link",
                                toggleable: true,
                                groupValue: controller.redirectionType
                                    .toLowerCase()
                                    .toString(),
                                onChanged: (value) {
                                  print(value);
                                  controller.setRedirectionType(value);
                                }),
                            Text(
                              "Redirect to a link",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.9)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  controller.redirectionType == "link"
                      ? Container(
                          width: screenWidth,
                          child: TextFormField(
                            controller: controller.textEditingController,
                            maxLines: null,
                            decoration:
                                InputDecoration(hintText: "Link or Url"),
                            onChanged: (value) {
                              controller.redirectionUrl =
                                  controller.textEditingController.toString();
                            },
                          ),
                        )
                      : Container()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
