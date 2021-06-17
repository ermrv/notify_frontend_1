import 'package:MediaPlus/MODULES/ContentDisplayTemplateMangerModule/views/ContestPostRelatedViews/ContestPostDisplayTemplate.dart';
import 'package:MediaPlus/MODULES/ContestingModule/ContestHostingModule/controllers/ContestHostingHistoryController.dart';
import 'package:MediaPlus/MODULES/ContestingModule/ContestHostingModule/views/CreateContestScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class ContestHostingHistoryScreen extends StatelessWidget {
  final ContestHostingHistoryController contestHostingHistoryController =
      Get.put(ContestHostingHistoryController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContestHostingHistoryController>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                title: Text("All Contests"),
                actions: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                    child: TextButton(
                        onPressed: () {
                          Get.to(() => CreateContestScreen());
                        },
                        child: Text("New Contest")),
                  ),
                ],
              ),
              body: controller.contestHostingHistoryData == null
                  ? Center(
                      child: SpinKitPulse(
                        color: Colors.blue,
                      ),
                    )
                  : controller.contestHostingHistoryData.length == 0
                      ? Container(
                          child: Center(
                            child: Text("No Contest Hosted!"),
                          ),
                        )
                      : ListView(
                          children: [
                            for (var i in controller.contestHostingHistoryData)
                              ContestPostDisplayTemplate(postContent: i)
                            
                          ],
                        ),
            ));
  }
}
