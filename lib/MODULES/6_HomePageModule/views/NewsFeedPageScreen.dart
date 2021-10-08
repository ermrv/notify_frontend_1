import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ContentDisplayTemplateProvider.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ReferenceRelatedViews/UserStatusReferenceLayout.dart';
import 'package:MediaPlus/MODULES/6_HomePageModule/TrendingPostDisplayRelated/views/TrendingPostReferenceTemplate.dart';
import 'package:MediaPlus/MODULES/6_HomePageModule/controllers/NewsFeedPageController.dart';
import 'package:MediaPlus/MODULES/6_HomePageModule/views/AddPostReferenceView.dart';
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
              child: controller.newsFeedData == null
                  ? Container(
                      child: Center(
                        child: SpinKitPulse(
                          color: Colors.blue,
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () {
                        return controller.getRecentPostsData();
                      },
                      child: ListView(
                        controller: controller.scrollController,
                        children: [
                          TrendingPostReferenceTemplate(data: []),
                          AddPostReferenceView(),
                          controller.newsFeedData.length == 0
                              ? Center(child: Text("No posts yet"))
                              : ContentDisplayTemplateProvider(
                                  data: controller.newsFeedData,controller: controller,)
                        ],
                      ),
                    ),
            ));
  }
}
