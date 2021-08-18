import 'dart:ui';

import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/10_PostPromotionModule/controllers/PromotedPostActionSelectorController.dart';
import 'package:flutter/material.dart';
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
      },
      builder: (controller) => Scaffold(
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
                "Duration: " + controller.duration.toString()+ " Hrs",
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

            
          ],
        ),
      ),
    );
  }
}
