import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/13_SearchEngineModule/controllers/SearchInputPageController.dart';
import 'package:MediaPlus/MODULES/13_SearchEngineModule/views/SearchResultsDisplayPageScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchInputPageScreen extends StatelessWidget {
  final _controller = Get.put(SearchInputPageController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchInputPageController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            height: 40.0,
            width: screenWidth,
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "Search for people, posts and more.."),
              autofocus: true,
              controller: controller.textEditingController,
              onEditingComplete: () {
                controller.search();
              },
            ),
          ),
        ),
      ),
    );
  }
}
