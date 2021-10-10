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
        print(trendingPostIdList);
        controller.initialIndex = initialIndex;
        controller.initialise();
      },
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text("Top trending"),
        ),
        body: PageView(
          scrollDirection: Axis.horizontal,
          controller: controller.pageController,
          children: [
            for (var i in trendingPostIdList)
              SpecificPostDisplayPageScreen(postId: i["postId"])
          ],
        ),
      ),
    );
  }
}
