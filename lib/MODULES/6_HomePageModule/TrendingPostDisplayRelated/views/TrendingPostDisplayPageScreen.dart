import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/SpecificPostRelated/views/SpecificPostDisplayPageScreen.dart';
import 'package:MediaPlus/MODULES/6_HomePageModule/TrendingPostDisplayRelated/controllers/TrendingPostDisplayPageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TrendingPostDisplayPageScreen extends StatelessWidget {
  final List trendingPostIdList;
  final int initialIndex;

  TrendingPostDisplayPageScreen(
      {Key key, @required this.trendingPostIdList, @required this.initialIndex})
      : super(key: key);

  final controller = Get.put(TrendingPostDisplayPageController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrendingPostDisplayPageController>(
      initState: (state) {
        controller.initialIndex = initialIndex;
        controller.initialise();
      },
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text("Top trending"),
        ),
        body: PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: controller.pageController,
            itemCount: trendingPostIdList.length,
            itemBuilder: (context, index) {
              return SpecificPostDisplayPageScreen(
                  postId: trendingPostIdList[index]["postId"]);
            }),
      ),
    );
  }
}
