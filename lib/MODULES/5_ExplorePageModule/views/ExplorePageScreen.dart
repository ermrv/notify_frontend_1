import 'package:MediaPlus/MODULES/13_SearchEngineModule/views/SearchInputPageScreen.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ContentDisplayTemplateProvider.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ReferenceRelatedViews/ContestPostReferenceLayout.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ReferenceRelatedViews/EventPostReferenceLayout.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ReferenceRelatedViews/ImagePostReferenceLayout.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ReferenceRelatedViews/ProfileReferenceRelated/ProfileReferenceLayout.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ReferenceRelatedViews/TagsReferenceLayout.dart';
import 'package:MediaPlus/MODULES/5_ExplorePageModule/controllers/ExplorePageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class ExplorePageScreen extends StatelessWidget {
  final explorePageController = Get.put(ExplorePageController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExplorePageController>(
      builder: (controller) => Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text("Explore"),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(SearchInputPageScreen());
                  },
                  icon: Icon(
                    Feather.search,
                    size: 22.0,
                  )),
              Container(
                width: 3.0,
              )
            ],
          ),
          body: controller.explorePageData.length == 0
              ? Center(
                  child: SpinKitPulse(
                    color: Colors.blue,
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () {
                    return controller.getRecentPostsData();
                  },
                  child: ListView(
                    controller: controller.scrollController,
                    children: [
                      ContentDisplayTemplateProvider(
                        data: controller.explorePageData,
                        controller: controller,
                      ),
                    ],
                  ),
                )),
    );
  }
}
