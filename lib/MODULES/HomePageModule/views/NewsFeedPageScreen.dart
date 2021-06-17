import 'package:MediaPlus/MODULES/ContentDisplayTemplateMangerModule/views/ContentDisplayTemplateProvider.dart';
import 'package:MediaPlus/MODULES/HomePageModule/controllers/NewsFeedPageController.dart';
import 'package:MediaPlus/MODULES/HomePageModule/views/AddPostReferenceView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class NewsFeedPageScreen extends StatelessWidget {
  final newsFeedPageController = Get.put(NewsFeedPageController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsFeedPageController>(
        builder: (controller) => MediaQuery.removeViewPadding(
              removeTop: true,
              context: context,
              child: controller.data.length == 0
                  ? Container(
                      child: Center(
                        child: SpinKitPulse(
                          color: Colors.blue,
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () {
                        return controller.getData();
                      },
                      child: NotificationListener<ScrollNotification>(
                        // ignore: missing_return
                        onNotification: (notification) {
                          controller.scrollListener(notification);
                        },
                        child: ListView(
                          children: [
                            AddPostReferenceView(),
                            ContentDisplayTemplateProvider(data: controller.data)
                          ],
                        )
                      ),
                    ),
            ));
  }
}
