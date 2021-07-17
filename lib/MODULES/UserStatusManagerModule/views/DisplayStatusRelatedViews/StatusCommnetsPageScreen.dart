import 'package:MediaPlus/MODULES/UserStatusManagerModule/controllers/DisplayStatusRelatedControllers/StatusCommentsPageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusCommentsPageScreen extends StatelessWidget {
  final String statusId;

  StatusCommentsPageScreen({Key key, this.statusId}) : super(key: key);

  final controller = Get.put(StatusCommentsPageController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatusCommentsPageController>(
        initState: (state) {
          controller.statusId = statusId;
          controller.initialise();
          
        },
        builder: (controller) => Scaffold(
              appBar: AppBar(
                title: Text("Seen by"),
              ),
              body: ListView(
                children: [for (var i in controller.commentsData) Container()],
              ),
            ));
  }
}
